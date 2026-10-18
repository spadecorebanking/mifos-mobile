# Custom deployment images

Use this checklist when branding the internet banking web app and mobile apps.
Paths below are relative to the repository root. Most images are bundled local
resources; web sharing previews use image URLs in HTML.

## Shared web and mobile images

| Where it appears | File to replace |
| --- | --- |
| Home and transfer headers, login, language onboarding | `core/ui/src/commonMain/composeResources/drawable/spade_xml_logo.xml` |
| PDF receipt logo | `core/ui/src/commonMain/composeResources/drawable/ic_icon_mifos_logo.svg` |
| About and App Info logo | `feature/settings/src/commonMain/composeResources/drawable/mifos_icon.png` |
| Additional App Info illustration | `feature/settings/src/commonMain/composeResources/drawable/mifo_app_info_icon.png` |
| Passcode component logo | `libs/mifos-passcode/src/commonMain/composeResources/drawable/lib_mifos_passcode_mifos_logo.jpg` |
| Powered-by component | `core/ui/src/commonMain/composeResources/drawable/ic_icon_powered_logo.xml` |

The header uses `Res.drawable.spade_xml_logo` in `HomeScreen.kt`, `TptScreen.kt`,
`LoginScreen.kt`, and `SetOnboardingLanguageScreen.kt`. This XML was converted from
`ic_icon_mifos_logo.svg`; editing the SVG does **not** regenerate the XML.
Keep both in sync when changing the brand mark.

## Platform images

| Platform / use | Files to replace |
| --- | --- |
| Web browser tab | `cmp-web/src/jsMain/resources/favicon.ico` |
| Web social sharing preview | `og:image` and `twitter:image` URLs in `cmp-web/src/jsMain/resources/index.html` |
| Wasm web build, if deployed | `cmp-web/src/wasmJsMain/resources/favicon.ico` and metadata in the adjacent `index.html` |
| Android launcher | `cmp-android/src/main/res/mipmap-*/ic_launcher*.webp` and adaptive icon definitions in `mipmap-anydpi-v26/` |
| Android splash | `cmp-android/src/main/res/drawable/splash_icon.webp` (referenced by both light and dark splash themes) |
| Android demo flavor | Launcher assets under `cmp-android/src/demo/res/mipmap-*/`; these override main assets |
| Android store artwork | `cmp-android/src/main/ic_launcher-playstore.png` and the demo equivalent |
| iOS app icon | `cmp-ios/iosApp/Assets.xcassets/AppIcon.appiconset/` (keep `Contents.json` consistent with the images) |
| Desktop app icon | `cmp-desktop/icons/ic_launcher.png`, `ic_launcher.ico`, and `ic_launcher.icns` |

## Replacement steps

1. Replace each relevant asset, keeping its filename and format to preserve code
   references. Use Android vector drawable XML for `.xml` images; an SVG cannot
   simply be renamed to XML. For a new resource name, update its generated
   resource imports and `Res.drawable` usages.
2. Preserve aspect ratios and allow padding for launcher icon masks. Check logos
   on light and dark backgrounds: the current Spade vector has a black fill.
3. Update web titles, descriptions, deployment URL, and sharing image dimensions
   in `index.html` alongside the preview image URLs.
4. Rebuild and redeploy web with `./gradlew :cmp-web:jsBrowserDistribution` (or the
   Docker workflow). Rebuild and install mobile apps for their asset changes.
5. Verify login, onboarding, home, transfers, About/App Info, passcode, PDF
   receipts, browser favicon, and mobile launcher/splash screens. Refresh browser
   caches when checking favicons.

Files ending in `_org` are backups, not the active branding references above.
Older assets such as `ic_icon_logo_1.xml` may remain in the tree; confirm actual
usages before changing them. To locate a resource's callers, run:

```bash
rg -n 'spade_xml_logo|ic_icon_logo_1|mifos_icon|ic_icon_powered_logo' --glob '*.kt'
```
