# Weatherly
### Open source weather app
<p float="left">
<img src="https://raw.githubusercontent.com/vferreirati/Weatherly-app/feat/readme/imgs/home.png" width="300" />
<img src="https://raw.githubusercontent.com/vferreirati/Weatherly-app/feat/readme/imgs/details.png" width="300" />
<img src="https://raw.githubusercontent.com/vferreirati/Weatherly-app/feat/readme/imgs/settings.png" width="300" />
</p>

This application takes a modular approach to its packages.

The `weatherly-core` package contains all of the business logic of the application, like cubits, netclient.

The `weatherly` package is the mobile application package.

This approach was taken to make use of dart's modularity, this way we can have multiple applications using the `core` of the application.

In a real case scenario, these packages could be splitted even more.

## Libraries
- bloc (Core package)
- flutter_bloc (Mobile app package)
- dio
- equatable
- flutter_svg
- intl
- shared_preferences

## Lint rules
```
always_put_required_named_parameters_first: false
avoid_classes_with_only_static_members: true
prefer_single_quotes: true
public_member_api_docs: true
lines_longer_than_80_chars: true
always_specify_types: false
```
