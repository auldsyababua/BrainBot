import pandas as pd
import re

# Company ID from the created record
COMPANY_ID = '4e3daa5f-9015-4ae8-a79c-620ccc45757f'

# Partners list (to be added to partners table)
PARTNERS = [
    'Flober LLC', 'Malama Energy', 'Operation Orange', 'Operation Orange LLC',
    'Scott Aulds', 'Shawn Leary', 'WasteWatt Ventures LLC', 'Zapata II, LLC'
]

# True customers/contractors
CUSTOMERS_CONTRACTORS = [
    'Alpha Centauri Contractors', 'Asics Miners US', 'Ballard Law', 
    'HeatCore Inc', 'Upstream Data, LLC', 'Vibe Energy Systems LLC'
]

def clean_numeric(value):
    """Clean numeric values from Excel"""
    if pd.isna(value) or value == '' or value is None:
        return 0
    if isinstance(value, str):
        # Remove commas, parentheses (for negatives), and currency symbols
        value = value.replace(',', '').replace('$', '').strip()
        if value.startswith('(') and value.endswith(')'):
            value = '-' + value[1:-1]
    try:
        return float(value)
    except:
        return 0

def parse_date(date_str):
    """Parse date from various formats"""
    if pd.isna(date_str) or date_str == '':
        return None
    try:
        if isinstance(date_str, pd.Timestamp):
            return date_str.strftime('%Y-%m-%d')
        return pd.to_datetime(date_str).strftime('%Y-%m-%d')
    except:
        return None

def determine_account_type(account_number):
    """Determine account type based on account number"""
    num = str(account_number)
    if num.startswith('1'):
        return 'Asset', 'Debit'
    elif num.startswith('2'):
        return 'Liability', 'Credit'
    elif num.startswith('3'):
        return 'Equity', 'Credit'
    elif num.startswith('4') or num.startswith('5'):
        return 'Income', 'Credit'
    elif num.startswith('6') or num.startswith('7') or num.startswith('8'):
        return 'Expense', 'Debit'
    else:
        return 'Asset', 'Debit'  # Default

# 1. Extract Chart of Accounts from various sources
print("\n1. EXTRACTING CHART OF ACCOUNTS")
print("="*60)

accounts = {}

# From Trial Balance
trial_balance_df = pd.read_excel('transactions/Trial_balance.xlsx', sheet_name='Trial Balance', skiprows=3)
trial_balance_df.columns = ['account_full', 'debit', 'credit']
trial_balance_df = trial_balance_df[trial_balance_df['account_full'].notna()]
trial_balance_df = trial_balance_df[~trial_balance_df['account_full'].str.contains('Total', na=False)]

for _, row in trial_balance_df.iterrows():
    account_full = str(row['account_full']).strip()
    if account_full and account_full != 'nan':
        # Extract account number and name
        match = re.match(r'^(\d+)\s+(.+)$', account_full)
        if match:
            account_num = match.group(1)
            account_name = match.group(2)
            account_type, normal_balance = determine_account_type(account_num)
            
            if account_num not in accounts:
                accounts[account_num] = {
                    'account_number': account_num,
                    'account_name': account_name,
                    'account_type': account_type,
                    'normal_balance': normal_balance,
                    'opening_debit': clean_numeric(row['debit']),
                    'opening_credit': clean_numeric(row['credit'])
                }

print(f"Found {len(accounts)} accounts from Trial Balance")

# Generate SQL for accounts
print("\n2. GENERATING SQL STATEMENTS")
print("="*60)

# Chart of Accounts SQL
with open('insert_accounts.sql', 'w') as f:
    f.write("-- Insert Chart of Accounts\n")
    f.write("-- Generated from QuickBooks export\n\n")
    
    for account_num, account_data in sorted(accounts.items()):
        account_id_display = f"ACC-{account_num}"
        opening_balance = account_data['opening_debit'] - account_data['opening_credit']
        
        sql = f"""INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    '{account_id_display}', '{COMPANY_ID}', '{account_num}', 
    '{account_data['account_name'].replace("'", "''")}', 
    '{account_data['account_type']}', '{account_data['normal_balance']}', 
    {opening_balance}, true
) ON CONFLICT (account_id_display) DO NOTHING;
"""
        f.write(sql)

print("Created insert_accounts.sql")

# Partners SQL
print("\n3. EXTRACTING PARTNERS FROM CUSTOMERS")
customers_df = pd.read_excel('transactions/Customers.xlsx', sheet_name='Customer Contact List', skiprows=3)
customers_df.columns = ['empty', 'customer_name', 'phone', 'email', 'full_name', 'billing_address', 'shipping_address']
customers_df = customers_df[customers_df['customer_name'].notna()]
customers_df = customers_df[customers_df['customer_name'] != 'Customer']

with open('insert_partners.sql', 'w') as f:
    f.write("-- Insert Partners (from QuickBooks customers)\n\n")
    
    partner_count = 0
    for _, row in customers_df.iterrows():
        customer_name = row['customer_name']
        if any(partner.lower() in customer_name.lower() for partner in PARTNERS):
            partner_count += 1
            partner_id_display = f"PART-{str(partner_count).zfill(3)}"
            
            # Determine partner type
            partner_type = 'Investor'  # Default
            if 'LLC' in customer_name or 'Ventures' in customer_name:
                partner_type = 'Investor'
            
            sql = f"""INSERT INTO public.partners (
    partner_id_display, partner_name, partner_type, 
    primary_contact_name, primary_contact_email, is_active
) VALUES (
    '{partner_id_display}', '{customer_name.replace("'", "''")}', '{partner_type}',
    {f"'{row['full_name'].replace("'", "''")}'" if pd.notna(row['full_name']) else 'NULL'},
    {f"'{row['email'].replace("'", "''")}'" if pd.notna(row['email']) else 'NULL'},
    true
) ON CONFLICT (partner_name) DO NOTHING;
"""
            f.write(sql)

print(f"Created insert_partners.sql with {partner_count} partners")

# Accounting Customers SQL
with open('insert_accounting_customers.sql', 'w') as f:
    f.write("-- Insert Accounting Customers (contractors/true customers)\n\n")
    
    customer_count = 0
    for _, row in customers_df.iterrows():
        customer_name = row['customer_name']
        if any(customer.lower() in customer_name.lower() for customer in CUSTOMERS_CONTRACTORS):
            customer_count += 1
            customer_id_display = f"CUST-{str(customer_count).zfill(3)}"
            
            sql = f"""INSERT INTO public.accounting_customers (
    customer_id_display, company_id, name, full_name, email, 
    billing_address, shipping_address, is_active
) VALUES (
    '{customer_id_display}', '{COMPANY_ID}', '{customer_name.replace("'", "''")}',
    {f"'{row['full_name'].replace("'", "''")}'" if pd.notna(row['full_name']) else 'NULL'},
    {f"'{row['email'].replace("'", "''")}'" if pd.notna(row['email']) else 'NULL'},
    {f"'{row['billing_address'].replace("'", "''")}'" if pd.notna(row['billing_address']) else 'NULL'},
    {f"'{row['shipping_address'].replace("'", "''")}'" if pd.notna(row['shipping_address']) else 'NULL'},
    true
);
"""
            f.write(sql)

print(f"Created insert_accounting_customers.sql with {customer_count} customers")

# Accounting Employees SQL
employees_df = pd.read_excel('transactions/Employees.xlsx', sheet_name='Employee Contact List', skiprows=3)
employees_df.columns = ['empty', 'employee_name', 'phone', 'email', 'address']
employees_df = employees_df[employees_df['employee_name'].notna()]
employees_df = employees_df[employees_df['employee_name'] != 'Employee']

with open('insert_accounting_employees.sql', 'w') as f:
    f.write("-- Insert Accounting Employees\n\n")
    
    for idx, row in employees_df.iterrows():
        employee_id_display = f"EMP-{str(idx+1).zfill(3)}"
        
        sql = f"""INSERT INTO public.accounting_employees (
    employee_id_display, company_id, name, email, phone, address, is_active
) VALUES (
    '{employee_id_display}', '{COMPANY_ID}', '{row['employee_name'].replace("'", "''")}',
    {f"'{row['email'].replace("'", "''")}'" if pd.notna(row['email']) else 'NULL'},
    {f"'{row['phone'].replace("'", "''")}'" if pd.notna(row['phone']) else 'NULL'},
    {f"'{row['address'].replace("'", "''")}'" if pd.notna(row['address']) else 'NULL'},
    true
);
"""
        f.write(sql)

print(f"Created insert_accounting_employees.sql with {len(employees_df)} employees")

print("\n4. SQL FILES CREATED:")
print("  - insert_accounts.sql")
print("  - insert_partners.sql")
print("  - insert_accounting_customers.sql")
print("  - insert_accounting_employees.sql")
print("\nRun these SQL files in Supabase to complete the migration.")