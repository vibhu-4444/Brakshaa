---
name: Agro-Premium Ecosystem
colors:
  surface: '#faf9f4'
  surface-dim: '#dbdad5'
  surface-bright: '#faf9f4'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f5f4ef'
  surface-container: '#efeee9'
  surface-container-high: '#e9e8e3'
  surface-container-highest: '#e3e3de'
  on-surface: '#1b1c19'
  on-surface-variant: '#3e4941'
  inverse-surface: '#30312e'
  inverse-on-surface: '#f2f1ec'
  outline: '#6e7a70'
  outline-variant: '#bdcabf'
  surface-tint: '#006d42'
  primary: '#006a40'
  on-primary: '#ffffff'
  primary-container: '#0d8553'
  on-primary-container: '#f6fff5'
  inverse-primary: '#74dba0'
  secondary: '#5d5f5f'
  on-secondary: '#ffffff'
  secondary-container: '#dfe0e0'
  on-secondary-container: '#616363'
  tertiary: '#775600'
  on-tertiary: '#ffffff'
  tertiary-container: '#966e00'
  on-tertiary-container: '#fffbff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#90f7bb'
  primary-fixed-dim: '#74dba0'
  on-primary-fixed: '#002111'
  on-primary-fixed-variant: '#005231'
  secondary-fixed: '#e2e2e2'
  secondary-fixed-dim: '#c6c6c7'
  on-secondary-fixed: '#1a1c1c'
  on-secondary-fixed-variant: '#454747'
  tertiary-fixed: '#ffdea3'
  tertiary-fixed-dim: '#fdbc13'
  on-tertiary-fixed: '#261900'
  on-tertiary-fixed-variant: '#5d4200'
  background: '#faf9f4'
  on-background: '#1b1c19'
  surface-variant: '#e3e3de'
typography:
  display-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 4px
  xs: 8px
  sm: 16px
  md: 24px
  lg: 32px
  xl: 48px
  container-margin: 20px
  gutter: 16px
---

## Brand & Style
The design system embodies a premium, intelligent farming ecosystem that bridges high-technology with organic growth. The brand personality is authoritative yet nurturing, catering to a demographic that values precision, sustainability, and sophisticated aesthetics. 

The style is a hybrid of **Minimalism** and **Glassmorphism**, drawing inspiration from industry-leading SaaS platforms. It prioritizes clarity through generous whitespace and elegant depth. The interface should feel "light" and "airy," using translucent layers and subtle gradients to imply the advanced AI processing happening beneath a simple, approachable surface.

## Colors
The palette is rooted in the natural world but refined for a digital-first experience. 

- **Primary Emerald (#1E8E5B):** Used for primary actions, success states, and brand-heavy elements. It represents vitality and technological growth.
- **Secondary White (#FFFFFF):** The foundation for glassmorphism panels and high-contrast surfaces.
- **Accent Gold (#F4B400):** Used sparingly for "smart" insights, premium features, and high-priority alerts. 
- **Background Soft Beige (#F8F7F2):** Replaces harsh whites to provide a more natural, paper-like quality that reduces eye strain in field environments.

For Dark Mode, the Background shifts to a deep charcoal-green (#0D1410), while the Emerald Green maintains its vibrancy through increased luminosity.

## Typography
The typography system uses **Plus Jakarta Sans** for headlines and labels to provide a friendly, modern, and slightly rounded geometric feel. This is paired with **Inter** for body copy to ensure maximum legibility for data-heavy AI insights and systematic reading.

Hierarchy is established through weight and scale rather than decorative elements. Large display headings should use tighter letter spacing for a more "designed" editorial appearance, while body text maintains standard tracking for readability.

## Layout & Spacing
This design system follows a **Mobile-First Fluid Grid** philosophy. The core layout relies on a 4-column grid for mobile and a 12-column grid for tablet/desktop. 

- **Mobile:** 20px side margins to allow the UI to "breathe" against the physical device edges.
- **Vertical Rhythm:** Spacing between sections should be generous (32px or 48px) to reinforce the minimal, premium aesthetic.
- **Safe Areas:** Adhere strictly to mobile safe areas for bottom-fixed navigation bars and top headers.

## Elevation & Depth
Depth is achieved through **Glassmorphism** and soft, ambient shadows. Layers are defined as follows:

1.  **Base Layer:** The Soft Beige background.
2.  **Glass Layer:** Semi-transparent white surfaces (`rgba(255, 255, 255, 0.7)`) with a `20px` backdrop blur. These surfaces feature a `1px` inner stroke in semi-transparent white to simulate light catching the edge of the glass.
3.  **Elevation Layer:** Used for floating buttons or active modals. These use a very soft, diffused shadow: `0px 10px 30px rgba(0, 0, 0, 0.05)`.

Avoid heavy black shadows; instead, use tinted shadows (a darker version of the surface color) to keep the UI feeling integrated and natural.

## Shapes
In alignment with the premium nature of the ecosystem, shapes are significantly rounded to evoke a sense of approachability and organic flow. 

All primary cards and containers must use a corner radius of **18px**. Smaller elements like buttons or tags should use the `rounded-lg` (16px) or `rounded-xl` (24px) scale to maintain a consistent visual language. Inputs and search bars should be fully pill-shaped (32px+) to distinguish them from structural card elements.

## Components

- **Buttons:** Primary buttons use a solid Emerald Green fill with white text. Secondary buttons use a Glassmorphic background with an Emerald border. All buttons should have a minimum height of 48px for mobile accessibility.
- **Glass Cards:** The "hero" component of the system. Cards feature the 18px radius, a subtle 1px white border, and a 20px backdrop blur. Backgrounds of cards can feature a very soft Emerald-to-Gold linear gradient at 10% opacity.
- **Chips & Tags:** Small, pill-shaped elements used for crop status (e.g., "Healthy," "Harvest Ready"). Use low-saturation background tints of the status color with high-saturation text.
- **Input Fields:** Minimalist design with a Soft Beige background slightly darker than the main page. On focus, the border transitions to Emerald Green with a soft outer glow.
- **Bottom Navigation:** A fixed glass bar at the bottom of the screen with blurred transparency, allowing the content to scroll behind it. Icons should be "duotone" style, using Emerald Green and a secondary tint.
- **Progress Gauges:** Circular indicators for soil moisture or AI health scores should use the Accent Gold for high-value data points.