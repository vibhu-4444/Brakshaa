---
name: Cinematic Liquid Glass
colors:
  surface: '#0c1324'
  surface-dim: '#0c1324'
  surface-bright: '#33394c'
  surface-container-lowest: '#070d1f'
  surface-container-low: '#151b2d'
  surface-container: '#191f31'
  surface-container-high: '#23293c'
  surface-container-highest: '#2e3447'
  on-surface: '#dce1fb'
  on-surface-variant: '#e6bdb8'
  inverse-surface: '#dce1fb'
  inverse-on-surface: '#2a3043'
  outline: '#ac8884'
  outline-variant: '#5c403c'
  surface-tint: '#ffb4ab'
  primary: '#ffb4ab'
  on-primary: '#690005'
  primary-container: '#dc2626'
  on-primary-container: '#fff6f5'
  inverse-primary: '#bf0715'
  secondary: '#b4c5ff'
  on-secondary: '#002a78'
  secondary-container: '#0053db'
  on-secondary-container: '#cdd7ff'
  tertiary: '#d2bbff'
  on-tertiary: '#3f008e'
  tertiary-container: '#8848f9'
  on-tertiary-container: '#fdf6ff'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#ffdad6'
  primary-fixed-dim: '#ffb4ab'
  on-primary-fixed: '#410002'
  on-primary-fixed-variant: '#93000b'
  secondary-fixed: '#dbe1ff'
  secondary-fixed-dim: '#b4c5ff'
  on-secondary-fixed: '#00174b'
  on-secondary-fixed-variant: '#003ea8'
  tertiary-fixed: '#eaddff'
  tertiary-fixed-dim: '#d2bbff'
  on-tertiary-fixed: '#25005a'
  on-tertiary-fixed-variant: '#5a00c6'
  background: '#0c1324'
  on-background: '#dce1fb'
  surface-variant: '#2e3447'
typography:
  display-lg:
    fontFamily: Space Grotesk
    fontSize: 72px
    fontWeight: '700'
    lineHeight: 80px
    letterSpacing: -0.04em
  headline-lg:
    fontFamily: Space Grotesk
    fontSize: 40px
    fontWeight: '500'
    lineHeight: 48px
    letterSpacing: -0.02em
  headline-lg-mobile:
    fontFamily: Space Grotesk
    fontSize: 32px
    fontWeight: '500'
    lineHeight: 40px
    letterSpacing: -0.02em
  body-md:
    fontFamily: Geist
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: 0.01em
  label-caps:
    fontFamily: JetBrains Mono
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.2em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 8px
  container-max: 1440px
  gutter: 24px
  margin-mobile: 20px
  margin-desktop: 80px
  stack-sm: 12px
  stack-md: 32px
  stack-lg: 64px
---

## Brand & Style
The brand personality is ultra-premium, mysterious, and high-fidelity. It evokes the feeling of a digital sanctuary—a "Vault" that is both impenetrable and intellectually luminous. The design system leverages a "Liquid Glass" aesthetic, blending the precision of high-end consumer electronics with the atmospheric depth of cinematic sci-fi.

The target audience consists of high-net-worth individuals, tech enthusiasts, and collectors who value privacy and prestige. The emotional response is one of awe, security, and effortless sophistication.

**Design Style: Cinematic Glassmorphism**
- **Foundation:** Pure black voids paired with deep, structural navy shadows.
- **Lighting:** Ambient "breathing" glows that act as functional signifiers.
- **Surface:** Heavy translucent layers with physical properties of polished obsidian and liquid silica.

## Colors
The palette is rooted in absolute darkness to ensure the "Liquid Glass" elements pop with maximum contrast.

- **Background:** Pure `#000000` is mandatory for the "infinity pool" effect.
- **Accents:** Crimson Red (`#DC2626`), Electric Blue (`#2563EB`), and Velvet Purple (`#7C3AED`) are used exclusively for glow effects, active states, and interactive "liquid" highlights.
- **Neutral:** Deep Dark Navy (`#020617`) serves as the subtle structural fill for containers, preventing the UI from feeling "flat" black.
- **Glows:** Use radial gradients with 20% opacity of the accent colors to create ambient floor lighting beneath floating elements.

## Typography
The typography is futuristic and precision-engineered. 

- **Display & Headlines:** Use **Space Grotesk**. It provides a geometric, tech-forward edge. For "Ultra-Premium" moments, apply a subtle linear gradient to text (White to 70% Grey).
- **Body:** Use **Geist** for its exceptional readability and developer-tool heritage, which lends an air of "system-level" precision.
- **Data & Labels:** Use **JetBrains Mono** for all metadata, labels, and secondary actions. The monospaced nature reinforces the "Vault" and "Security" narrative.
- **Spacing:** Letter spacing should be generous for labels (`0.2em`) to evoke a high-fashion, minimal aesthetic.

## Layout & Spacing
The design system utilizes a **Fluid Grid** with extreme whitespace to emphasize the "floating" nature of the glass components.

- **Rhythm:** A strict 8px base unit governs all dimensions.
- **Margins:** Large horizontal margins (80px on desktop) create a "cinematic letterbox" feel for content.
- **Stacking:** Elements should be spaced aggressively. Large gaps between sections (64px+) prevent the UI from feeling cluttered, maintaining the "Apple-level" minimalism.
- **Reflow:** On mobile, margins reduce to 20px, and glass cards stack vertically. Background blurs are reduced by 50% on mobile to maintain performance.

## Elevation & Depth
Depth is the core differentiator of this design system. It is achieved through **Liquid Glass** layering:

1.  **Level 0 (Background):** Pure `#000000`.
2.  **Level 1 (Ambient Glow):** Large, soft radial gradients of accent colors positioned behind Level 2 cards.
3.  **Level 2 (Glass Surfaces):** Background blur of 24px, fill of `rgba(2, 6, 23, 0.6)`. A 1px inner stroke of `rgba(255, 255, 255, 0.1)` defines the edge.
4.  **Level 3 (Interactive Refraction):** On hover, cards gain a secondary 1px stroke of the primary accent color (e.g., Crimson) and the shadow spread increases from 20px to 40px with a 0.15 opacity.

**3D Tilt:** Large cards should utilize a subtle 5-degree JS-driven perspective tilt on hover, mimicking the way light hits a physical sheet of glass.

## Shapes
The shape language is sophisticated and modern, using "Rounded" (`0.5rem` base) to avoid the childish feel of pill-shapes while remaining softer than brutalist sharp edges.

- **Primary Cards:** Use `rounded-xl` (1.5rem / 24px) to create a premium, tablet-like feel.
- **Inputs & Small Buttons:** Use `rounded-lg` (1rem / 16px) for a comfortable touch and click target.
- **Special Elements:** Search bars and secondary tags may use pill shapes (3) to differentiate them from structural containers.

## Components

### Buttons
- **Primary:** Glass fill with a vibrant accent glow underneath. Text is white, high-contrast.
- **Secondary:** Transparent with the 1px white border. On hover, the border morphs into the Electric Blue accent.

### Glass Cards
- **Recipe:** 24px Blur + 1px white border (10% opacity) + Navy Tint (60% opacity).
- **Internal Glow:** Use a top-left subtle white linear gradient (10% to 0%) to simulate a "reflection" on the glass surface.

### Inputs
- **Style:** Underlined or fully enclosed glass containers. 
- **Active State:** The underline or border pulses slowly with the "Velvet Purple" accent, simulating a "breathing" system state.

### Chips/Tags
- **Style:** Small monospaced text inside a high-blur glass container. 
- **Interaction:** Glow intensifies when the user hovers, shedding light on the content behind it.

### Lists
- **Style:** Separated by "ghost lines"—1px wide gradients that fade to 0% at the edges, ensuring the list feels like it’s floating in space rather than boxed in.