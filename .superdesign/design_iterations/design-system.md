# BrainBot Mini App - Design System

## Brand Identity
**Mission**: Simple, focused productivity without the noise

## Design Tokens

### Colors
```css
/* Primary Palette */
--color-primary-50: #E3F2FD;
--color-primary-100: #BBDEFB;
--color-primary-200: #90CAF9;
--color-primary-300: #64B5F6;
--color-primary-400: #42A5F5;
--color-primary-500: #0088CC; /* Telegram Blue */
--color-primary-600: #1E88E5;
--color-primary-700: #1976D2;
--color-primary-800: #1565C0;
--color-primary-900: #0D47A1;

/* Neutral Palette */
--color-gray-50: #FAFAFA;
--color-gray-100: #F5F5F5;
--color-gray-200: #EEEEEE;
--color-gray-300: #E0E0E0;
--color-gray-400: #BDBDBD;
--color-gray-500: #9E9E9E;
--color-gray-600: #757575;
--color-gray-700: #616161;
--color-gray-800: #424242;
--color-gray-900: #212121;

/* Semantic Colors */
--color-success: #4CAF50;
--color-warning: #FF9800;
--color-error: #F44336;
--color-info: #2196F3;

/* Surfaces */
--color-background: #FFFFFF;
--color-surface: #F5F5F5;
--color-surface-elevated: #FFFFFF;
--color-overlay: rgba(0, 0, 0, 0.5);
```

### Typography
```css
/* Font Stack */
--font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;

/* Font Sizes */
--text-xs: 12px;
--text-sm: 14px;
--text-base: 16px;
--text-lg: 18px;
--text-xl: 20px;
--text-2xl: 24px;

/* Font Weights */
--font-regular: 400;
--font-medium: 500;
--font-semibold: 600;
--font-bold: 700;

/* Line Heights */
--leading-tight: 1.25;
--leading-normal: 1.5;
--leading-relaxed: 1.75;
```

### Spacing
```css
--space-0: 0;
--space-1: 4px;
--space-2: 8px;
--space-3: 12px;
--space-4: 16px;
--space-5: 20px;
--space-6: 24px;
--space-8: 32px;
--space-10: 40px;
--space-12: 48px;
--space-16: 64px;
```

### Border Radius
```css
--radius-sm: 4px;
--radius-md: 8px;
--radius-lg: 12px;
--radius-xl: 16px;
--radius-full: 9999px;
```

### Shadows
```css
--shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
--shadow-md: 0 4px 6px rgba(0, 0, 0, 0.07);
--shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
--shadow-xl: 0 20px 25px rgba(0, 0, 0, 0.1);
```

## Component Specifications

### Button Component
```
Primary Button:
- Background: var(--color-primary-500)
- Text: white
- Padding: 12px 24px
- Border Radius: var(--radius-md)
- Font: var(--font-medium) var(--text-base)
- Hover: var(--color-primary-600)
- Active: var(--color-primary-700)
- Disabled: opacity 0.5

Secondary Button:
- Background: transparent
- Border: 1px solid var(--color-gray-300)
- Text: var(--color-gray-700)
- Hover: var(--color-gray-50)
```

### Input Field
```
Default State:
- Border: 1px solid var(--color-gray-300)
- Background: white
- Padding: 10px 12px
- Border Radius: var(--radius-md)
- Font: var(--text-base)

Focus State:
- Border: 2px solid var(--color-primary-500)
- Outline: none
- Box Shadow: 0 0 0 3px var(--color-primary-50)

Error State:
- Border: 1px solid var(--color-error)
- Background: #FFF5F5
```

### Task Item
```
Container:
- Padding: var(--space-3) var(--space-4)
- Border Bottom: 1px solid var(--color-gray-100)
- Background: white

Checkbox:
- Size: 20px × 20px
- Border: 2px solid var(--color-gray-300)
- Border Radius: var(--radius-sm)
- Checked: var(--color-success) with white checkmark

Title:
- Font: var(--font-regular) var(--text-base)
- Color: var(--color-gray-900)
- Completed: line-through, var(--color-gray-400)

Due Date:
- Font: var(--text-xs)
- Color: var(--color-gray-500)
- Margin Top: var(--space-1)
```

### List Card
```
Container:
- Padding: var(--space-4)
- Border: 1px solid var(--color-gray-200)
- Border Radius: var(--radius-lg)
- Background: white
- Hover: border var(--color-primary-300)

Emoji:
- Size: 32px
- Margin Right: var(--space-3)

Title:
- Font: var(--font-medium) var(--text-base)
- Color: var(--color-gray-800)

Count:
- Font: var(--text-sm)
- Color: var(--color-gray-500)
```

### Navigation Tab
```
Container:
- Flex: 1
- Padding: var(--space-2) var(--space-3)
- Background: white

Icon:
- Size: 20px
- Color: var(--color-gray-500)
- Active: var(--color-primary-500)

Label:
- Font: var(--text-xs)
- Color: var(--color-gray-500)
- Active: var(--color-primary-500)
- Margin Top: var(--space-1)
```

### Chat Bubble
```
User Message:
- Background: var(--color-primary-500)
- Color: white
- Padding: var(--space-2) var(--space-3)
- Border Radius: var(--radius-lg)
- Max Width: 80%
- Align: right

Bot Message:
- Background: var(--color-gray-200)
- Color: var(--color-gray-800)
- Padding: var(--space-2) var(--space-3)
- Border Radius: var(--radius-lg)
- Max Width: 80%
- Align: left
```

### Modal
```
Overlay:
- Background: var(--color-overlay)
- Position: fixed, inset 0

Container:
- Background: white
- Border Radius: var(--radius-xl) var(--radius-xl) 0 0
- Padding: var(--space-6)
- Max Width: 512px
- Animation: slide up 300ms ease-out

Header:
- Font: var(--font-semibold) var(--text-lg)
- Margin Bottom: var(--space-4)

Close Button:
- Position: absolute, top-right
- Size: 24px
- Color: var(--color-gray-500)
```

## Animation Guidelines

### Transitions
```css
/* Default transition */
transition: all 200ms ease-in-out;

/* Fast interactions */
transition: all 150ms ease-out;

/* Smooth animations */
transition: all 300ms cubic-bezier(0.4, 0, 0.2, 1);
```

### Micro-interactions
- Button press: scale(0.98)
- Task complete: checkbox fill + fade
- Tab switch: slide indicator
- Modal open: fade + slide up
- Toast appear: slide in from top

## Accessibility Standards

### Touch Targets
- Minimum size: 44px × 44px
- Spacing between targets: 8px minimum

### Color Contrast
- Normal text: 4.5:1 minimum
- Large text: 3:1 minimum
- Interactive elements: 3:1 minimum

### Focus Indicators
- Visible focus ring on all interactive elements
- Focus ring color: var(--color-primary-500)
- Focus ring width: 2px
- Focus ring offset: 2px

### Screen Reader Support
- Semantic HTML elements
- ARIA labels for icons
- Role attributes where needed
- Keyboard navigation support

## Layout Grid

### Mobile (Default)
```
Columns: 4
Margin: 16px
Gutter: 16px
```

### Tablet (Optional)
```
Columns: 8
Margin: 24px
Gutter: 24px
```

## Icon Set
Using Lucide React icons:
- Tasks: `List`
- Lists: `Calendar`
- Chat: `MessageCircle`
- Add: `Plus`
- Check: `Check`
- Close: `X`
- Send: `Send`
- Settings: `Settings`
- Search: `Search`
- Filter: `Filter`

## Component States

### Interactive States
1. **Default**: Normal appearance
2. **Hover**: Subtle background change
3. **Active**: Pressed appearance
4. **Focus**: Visible focus ring
5. **Disabled**: 50% opacity
6. **Loading**: Show spinner
7. **Error**: Red border/background
8. **Success**: Green indicator

## Do's and Don'ts

### Do's ✅
- Keep it simple and focused
- Use consistent spacing
- Provide clear feedback
- Make touch targets large
- Use semantic colors
- Test on real devices

### Don'ts ❌
- Show technical metrics
- Use percentages unnecessarily
- Add marketing language
- Create deep navigation
- Use small touch targets
- Forget loading states

## Implementation Checklist

- [ ] Set up design tokens
- [ ] Create base components
- [ ] Implement navigation
- [ ] Build task views
- [ ] Create list management
- [ ] Add chat interface
- [ ] Test accessibility
- [ ] Optimize performance
- [ ] Deploy to production