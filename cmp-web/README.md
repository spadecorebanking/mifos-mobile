### Production builds

Run `./gradlew :cmp-web:jsBrowserDistribution` to build the web distribution.
Production Webpack configuration in `webpack.config.d/production.js` skips
JavaScript minification and bundled source maps to keep Compose packaging within
CI resource limits. Kotlin production compilation still eliminates dead code.
The resulting JavaScript is larger than a minified bundle; development builds
keep their source maps.

### Module Graph

```mermaid
%%{
  init: {
    'theme': 'neutral'
  }
}%%

graph LR
  subgraph :core
    :core:common["common"]
    :core:data["data"]
    :core:model["model"]
    :core:datastore["datastore"]
  end
  :mifospay-web --> :mifospay-shared
  :mifospay-web --> :core:common
  :mifospay-web --> :core:data
  :mifospay-web --> :core:model
  :mifospay-web --> :core:datastore
```
