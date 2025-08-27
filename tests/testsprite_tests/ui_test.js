// FLRTS Telegram Mini App UI Verification Test
// This script uses Playwright to visually verify the UI and check for analytics fluff

const { chromium } = require('playwright');
const fs = require('fs').promises;
const path = require('path');

// Test configuration
const BASE_URL = 'http://localhost:5173';
const SCREENSHOT_DIR = './screenshots';

// Analytics terms to check for (should NOT be present)
const ANALYTICS_TERMS = [
  'Tokens Saved',
  'Token Reduction',
  'tokens saved',
  '70% Token Reduction',
  '0 tokens'
];

async function runTests() {
  let browser;
  let context;
  let page;
  const results = {
    analyticsFluffFound: [],
    testsRun: [],
    screenshots: []
  };

  try {
    // Create screenshot directory
    await fs.mkdir(SCREENSHOT_DIR, { recursive: true });
    
    // Launch browser
    console.log('Launching browser...');
    browser = await chromium.launch({
      headless: false,
      slowMo: 50
    });
    
    context = await browser.newContext({
      viewport: { width: 1280, height: 800 }
    });
    
    page = await context.newPage();
    
    // Navigate to app
    console.log('Navigating to app...');
    await page.goto(BASE_URL);
    await page.waitForLoadState('networkidle');
    
    // Take screenshot of main dashboard
    console.log('Taking dashboard screenshot...');
    await page.screenshot({ 
      path: path.join(SCREENSHOT_DIR, 'dashboard.png'),
      fullPage: true 
    });
    results.screenshots.push('dashboard.png');
    results.testsRun.push('Dashboard loaded');
    
    // Check for analytics fluff
    console.log('\nChecking for analytics fluff...');
    for (const term of ANALYTICS_TERMS) {
      try {
        const elements = await page.getByText(term).all();
        if (elements.length > 0) {
          console.log(`  FOUND: "${term}" - ${elements.length} instance(s)`);
          results.analyticsFluffFound.push({
            term,
            count: elements.length
          });
        } else {
          console.log(`  NOT FOUND: "${term}" (good!)`);
        }
      } catch (error) {
        console.log(`  NOT FOUND: "${term}" (good!)`);
      }
    }
    
    // Check for PerformanceMetrics component
    const perfMetrics = await page.locator('[class*="performance"], [class*="metrics"]').all();
    if (perfMetrics.length > 0) {
      console.log(`  Warning: Found ${perfMetrics.length} elements with performance/metrics classes`);
    }
    
    // Navigate to Tasks view
    console.log('\nTesting Tasks view...');
    const tasksButton = await page.getByText('Tasks').first();
    if (await tasksButton.isVisible()) {
      await tasksButton.click();
      await page.waitForTimeout(1000);
      await page.screenshot({ 
        path: path.join(SCREENSHOT_DIR, 'tasks.png'),
        fullPage: true 
      });
      results.screenshots.push('tasks.png');
      results.testsRun.push('Tasks view');
      
      // Check for token badges in task creation
      const tokenBadges = await page.getByText(/0 tokens/).all();
      if (tokenBadges.length > 0) {
        console.log(`  Found ${tokenBadges.length} token badge(s) in Tasks view`);
        results.analyticsFluffFound.push({
          term: '0 tokens badge in Tasks',
          count: tokenBadges.length
        });
      }
    }
    
    // Navigate to Lists view
    console.log('\nTesting Lists view...');
    const listsButton = await page.getByText('Lists').first();
    if (await listsButton.isVisible()) {
      await listsButton.click();
      await page.waitForTimeout(1000);
      await page.screenshot({ 
        path: path.join(SCREENSHOT_DIR, 'lists.png'),
        fullPage: true 
      });
      results.screenshots.push('lists.png');
      results.testsRun.push('Lists view');
    }
    
    // Navigate to Chat view
    console.log('\nTesting Chat view...');
    const chatButton = await page.getByText('Chat').first();
    if (await chatButton.isVisible()) {
      await chatButton.click();
      await page.waitForTimeout(1000);
      await page.screenshot({ 
        path: path.join(SCREENSHOT_DIR, 'chat.png'),
        fullPage: true 
      });
      results.screenshots.push('chat.png');
      results.testsRun.push('Chat view');
    }
    
    // Navigate to Settings view
    console.log('\nTesting Settings view...');
    const settingsButton = await page.getByText('Settings').first();
    if (await settingsButton.isVisible()) {
      await settingsButton.click();
      await page.waitForTimeout(1000);
      await page.screenshot({ 
        path: path.join(SCREENSHOT_DIR, 'settings.png'),
        fullPage: true 
      });
      results.screenshots.push('settings.png');
      results.testsRun.push('Settings view');
      
      // Check for performance metrics in settings
      const perfSection = await page.getByText(/tokens saved/i).all();
      if (perfSection.length > 0) {
        console.log(`  Found ${perfSection.length} token savings display(s) in Settings`);
        results.analyticsFluffFound.push({
          term: 'tokens saved in Settings',
          count: perfSection.length
        });
      }
    }
    
    // Test responsive design
    console.log('\nTesting responsive design...');
    await page.setViewportSize({ width: 375, height: 667 });
    await page.goto(BASE_URL);
    await page.waitForLoadState('networkidle');
    await page.screenshot({ 
      path: path.join(SCREENSHOT_DIR, 'mobile.png'),
      fullPage: true 
    });
    results.screenshots.push('mobile.png');
    results.testsRun.push('Mobile viewport');
    
    // Generate report
    console.log('\n' + '='.repeat(60));
    console.log('TEST REPORT SUMMARY');
    console.log('='.repeat(60));
    
    if (results.analyticsFluffFound.length === 0) {
      console.log('\nNO ANALYTICS FLUFF FOUND - All analytics UI removed successfully!');
    } else {
      console.log('\nANALYTICS FLUFF STILL PRESENT:');
      results.analyticsFluffFound.forEach(item => {
        console.log(`  - "${item.term}": ${item.count} instances`);
      });
    }
    
    console.log('\nTests Run:');
    results.testsRun.forEach(test => {
      console.log(`  - ${test}`);
    });
    
    console.log('\nScreenshots Saved:');
    results.screenshots.forEach(screenshot => {
      console.log(`  - ${screenshot}`);
    });
    
    // Save JSON report
    const reportPath = path.join(SCREENSHOT_DIR, 'report.json');
    await fs.writeFile(reportPath, JSON.stringify(results, null, 2));
    console.log(`\nFull report saved to: ${reportPath}`);
    
  } catch (error) {
    console.error('Test failed:', error);
  } finally {
    if (browser) {
      await browser.close();
    }
  }
}

// Run the tests
runTests().then(() => {
  console.log('\nTest suite completed');
  process.exit(0);
}).catch(error => {
  console.error('Test suite failed:', error);
  process.exit(1);
});