# Important changes of Visual Studio Code

## Earliest version

![](IconFiles/AppIcon/0.1/appicon_32.png)

- No document icons.

- Associated file extensions:
  - ***bat*** (Windows command script),
    *cs* (C++ source code),
    ***css*** (CSS file),
    ***html***, ***htm*** (HTML document),
    ***js*** (Javascript file),
    ***jsp*** (Jakarta Server Pages),
    ***md*** (Markdown document),
    ***shtml*** (server-parsed HTML),
    ***svg*** (SVG document),
    ***ts*** (TypeScript file),
    ***txt*** (Plain Text File),
    ***xml*** (XML document),
    ***xsd*** (XML Schema),
    ***xslt***,
    ***yaml*** (YAML document).

## 0.4

- Append new file extension associations:
  - *ascx*, *asp*, *aspx*, *bash*, *bash_login*, *bash_logout*, *bash_profile*, *bashrc*, *bowerrc*, *cc*, *clj*, *cljs*, *cljx*, *clojure*, *cmd*, *coffee*, *config*, *cpp*, *cshtml*, *csproj*, *csx*, *ctp*, *cxx*, *dockerfile*, *dot*, *dtd*, *editorconfig*, *edn*, *eyaml*, *eyml*, *fs*, *fsi*, *fsscript*, *gemspec*, *gitattribute*, *gitconfig*, *gitignore*, *go*, *h*, *handlebars*, *hbs*, *hh*, *hpp*, *hxx*, *ini*, *jade*, *jav*, *java*, *jscsrc*, *jshintrc*, *jshtm*, *json*, *less*, *lua*, *m*, *makefile*, *markdown*, *mdoc*, *mdown*, *mdtext*, *mdtxt*, *mdwn*, *mkd*, *mkdn*, *ml*, *mli*, *nqp*, *p6*, *php*, *phtml*, *pl*, *pl6*, *pm*, *pm6*, *pod*, *pp*, *profile*, *properties*, *ps1*, *psd1*, *psgi*, *psm1*, *py*, *r*, *rs*, *rb*, *rhistory*, *rprofile*, *rt*, *scss*, *sh*, *sql*, *svgz*, *t*, *vb*, *wxi*, *wxl*, *wxs*, *xaml*, *yml*, *zsh*

## 0.6

- New application icon.

  ![](IconFiles/AppIcon/0.6/appicon_32.png)

## 0.8

- New document icons.

  ![](IconFiles/FileTypeIcons/0.8/AllOtherIcons_32.png)

## 0.9

- New directory:
  - *extensions* directory:
    - Mac: `~\.vscode\extensions`
    - Windows: `%USERPROFILE%\.vscode\extensions`

## 0.10

- Support extensions (plug-ins).

## [1.0](https://code.visualstudio.com/updates/vMarch)
 ![](https://img.shields.io/badge/-march_2016-informational)

- New application icon.

  ![](IconFiles/AppIcon/1.0/appicon_32.png)

- New document icons.

  ![](IconFiles/FileTypeIcons/1.0/AllOtherIcons_32.png)

- Multilingual Support. [^1]
  - Supported language: English (`en-US`), Simplified Chinese (`zh-CN`), Traditional Chinese (`zh-TW`), French (`fr`), German (`de`), Italian (`it`), Spanish (`es`), Japanese (`ja`), Korean (`ko`), Russian (`ru`).
  - Language configuration is saved in *locale.json* file.
    - Path of *locale.json*
      - Mac: `~/Library/Application Support/Code/User/locale.json`
      - Windows: `%USERPROFILE%\AppData\Roaming\Code\User\locale.json`
    - The content of the file is saved in JSON format.
    - The language code of the user's language is stored in the `locale` key in the *locale.json* file.

[^1]: https://code.visualstudio.com/updates/vMarch#_localization

- With [EULA](EULA/1/EULA.txt).

## [1.1](https://code.visualstudio.com/updates/vApril)
 ![](https://img.shields.io/badge/-april_2016-informational)

- Append new file extension associations:
  - *zlogin*, *zlogout*, *zprofile*, *zshenv*, *zshrc*

  See the [source code](https://github.com/microsoft/vscode/blob/1.1.0/build/gulpfile.vscode.js). (Line 109)

## [1.4](https://code.visualstudio.com/updates/July_2016)
 ![](https://img.shields.io/badge/-july_2016-informational)

- The *nqp* and *p6* file extensions are no longer associated.

  See the [source code](https://github.com/microsoft/vscode/blob/1.4.0/build/gulpfile.vscode.js#L108).

## [1.13](https://code.visualstudio.com/updates/v1_13)
 ![](https://img.shields.io/badge/-may_2017-informational)

- Append new file extension associations:
  - *code-workspace*, *xcodeproj*, *xcworkspace*

  See the [source code](https://github.com/microsoft/vscode/blob/1.13.0/build/gulpfile.vscode.js#L130).

## [1.15](https://code.visualstudio.com/updates/v1_15)
 ![](https://img.shields.io/badge/-July_2017-informational)

- First 64-bit Windows build. [^2]

[^2]: https://code.visualstudio.com/updates/v1_15#_windows-64-bit

## [1.17](https://code.visualstudio.com/updates/v1_17)
 ![](https://img.shields.io/badge/-september_2017-informational)

- New application icon.

  ![](IconFiles/AppIcon/1.17/appicon_32.png)

- New document icons.

  ![](IconFiles/FileTypeIcons/1.17/AllOtherIcons_32.png)

## [1.18](https://code.visualstudio.com/updates/v1_18)
 ![](https://img.shields.io/badge/-october_2017-informational)

- New application icon.

  ![](IconFiles/AppIcon/1.18/appicon_32.png)

- New document icons.

  ![](IconFiles/FileTypeIcons/1.18/AllOtherIcons_32.png)

## [1.24](https://code.visualstudio.com/updates/v1_24)
 ![](https://img.shields.io/badge/-may_2018-informational)

- Append new file extension associations.
  - *pug*

  See the [source code](https://github.com/microsoft/vscode/blob/1.24.0/build/gulpfile.vscode.js#L144).

## [1.25](https://code.visualstudio.com/updates/v1_25)
 ![](https://img.shields.io/badge/-june_2018-informational)

- The application can run in portable mode.
  - To run the application in portable mode, create a *data* directory within the VSCode's folder.


- Only English is provided as display language, other languages depend on language packs installed from VS Code Marketplace. [^3]
  - Language packs are stored as extensions in the *extensions* directory, and language pack extensions are named in the format `ms-ceintl.vscode-language-pack-<language>-<version>`.

[^3]:https://code.visualstudio.com/updates/v1_25#_language-packs

## [1.28](https://code.visualstudio.com/updates/v1_28)
 ![](https://img.shields.io/badge/-september_2018-informational)

- Append new file extension associations.
  - *mjs*

  See the [source code](https://github.com/microsoft/vscode/blob/1.28.0/build/gulpfile.vscode.js#L149).

- Added additional conditions for the application to run in portable mode.
  - Make sure the `target` key in *resources\app\product.json* is removed.

  See the [source code](https://github.com/microsoft/vscode/blob/1.28.0/src/bootstrap.js#L201).

- New document icons.    
    ![](IconFiles/FileTypeIcons/1.28/bat_128.png)
    ![](IconFiles/FileTypeIcons/1.28/bowerrc_32.png)
    ![](IconFiles/FileTypeIcons/1.28/c_32.png)
    ![](IconFiles/FileTypeIcons/1.28/config_32.png)
    ![](IconFiles/FileTypeIcons/1.28/cpp_32.png)
    ![](IconFiles/FileTypeIcons/1.28/cs_32.png)
    ![](IconFiles/FileTypeIcons/1.28/css_32.png)
    ![](IconFiles/FileTypeIcons/1.28/go_32.png)
    ![](IconFiles/FileTypeIcons/1.28/html_32.png)
    ![](IconFiles/FileTypeIcons/1.28/jade_32.png)
    ![](IconFiles/FileTypeIcons/1.28/java_32.png)
    ![](IconFiles/FileTypeIcons/1.28/js_32.png)
    ![](IconFiles/FileTypeIcons/1.28/markdown_32.png)
    ![](IconFiles/FileTypeIcons/1.28/php_32.png)
    ![](IconFiles/FileTypeIcons/1.28/ps1_32.png)
    ![](IconFiles/FileTypeIcons/1.28/py_32.png)
    ![](IconFiles/FileTypeIcons/1.28/rb_32.png)
    ![](IconFiles/FileTypeIcons/1.28/scss_32.png)
    ![](IconFiles/FileTypeIcons/1.28/sh_32.png)
    ![](IconFiles/FileTypeIcons/1.28/sql_32.png)
    ![](IconFiles/FileTypeIcons/1.28/ts_32.png)
    ![](IconFiles/FileTypeIcons/1.28/tsx_32.png)
    ![](IconFiles/FileTypeIcons/1.28/vue_32.png)
    ![](IconFiles/FileTypeIcons/1.28/xml_32.png)
    ![](IconFiles/FileTypeIcons/1.28/yaml_32.png)
    ![](IconFiles/FileTypeIcons/1.28/AllOtherIcons_32.png)

## [1.32](https://code.visualstudio.com/updates/v1_32)
 ![](https://img.shields.io/badge/-february_2019-informational)

- New [EULA](EULA/2/EULA.txt)

## [1.35](https://code.visualstudio.com/updates/v1_35)
 ![](https://img.shields.io/badge/-may_2019-informational)

- New application icon.

  ![](IconFiles/AppIcon/1.35/appicon_32.png)

- New document icons.
    
  ![](IconFiles/FileTypeIcons/1.35/bat_128.png)
  ![](IconFiles/FileTypeIcons/1.35/bowerrc_32.png)
  ![](IconFiles/FileTypeIcons/1.35/c_32.png)
  ![](IconFiles/FileTypeIcons/1.35/config_32.png)
  ![](IconFiles/FileTypeIcons/1.35/cpp_32.png)
  ![](IconFiles/FileTypeIcons/1.35/cs_32.png)
  ![](IconFiles/FileTypeIcons/1.35/css_32.png)
  ![](IconFiles/FileTypeIcons/1.35/go_32.png)
  ![](IconFiles/FileTypeIcons/1.35/html_32.png)
  ![](IconFiles/FileTypeIcons/1.35/jade_32.png)
  ![](IconFiles/FileTypeIcons/1.35/java_32.png)
  ![](IconFiles/FileTypeIcons/1.35/js_32.png)
  ![](IconFiles/FileTypeIcons/1.35/markdown_32.png)
  ![](IconFiles/FileTypeIcons/1.35/php_32.png)
  ![](IconFiles/FileTypeIcons/1.35/ps1_32.png)
  ![](IconFiles/FileTypeIcons/1.35/py_32.png)
  ![](IconFiles/FileTypeIcons/1.35/rb_32.png)
  ![](IconFiles/FileTypeIcons/1.35/scss_32.png)
  ![](IconFiles/FileTypeIcons/1.35/sh_32.png)
  ![](IconFiles/FileTypeIcons/1.35/sql_32.png)
  ![](IconFiles/FileTypeIcons/1.35/ts_32.png)
  ![](IconFiles/FileTypeIcons/1.35/tsx_32.png)
  ![](IconFiles/FileTypeIcons/1.35/vue_32.png)
  ![](IconFiles/FileTypeIcons/1.35/xml_32.png)
  ![](IconFiles/FileTypeIcons/1.35/yaml_32.png)
  ![](IconFiles/FileTypeIcons/1.35/AllOtherIcons_32.png)

## [1.40](https://code.visualstudio.com/updates/v1_40)
 ![](https://img.shields.io/badge/-october_2019-informational)

- New file:
  - *argv.json*
    - Path:
      - Mac: `~\Library\.vscode\argv.json`
      - Windows:
        - Standard: `%USERPROFILE%\.vscode\argv.json`
        - Portable: `<Visual Studio Code>\data\argv.json`
    - The *locale.json* file is deprecated and replaced by *argv.json* file.

  See the [source code](https://github.com/microsoft/vscode/blob/1.40.0/src/main.js#L58).

## [1.41](https://code.visualstudio.com/updates/v1_41)
 ![](https://img.shields.io/badge/-november_2019-informational)

- Append new file extension associations.
  - Javascript file: *cjs*

  See the [source code](https://github.com/microsoft/vscode/blob/1.41.0/build/lib/electron.js#L56).

## [1.46](https://code.visualstudio.com/updates/v1_46)
 ![](https://img.shields.io/badge/-may_2020-informational)

- Append new file extension associations.
  - *containerfile*

  See the [source code](https://github.com/microsoft/vscode/blob/1.46.0/build/lib/electron.ts#L72)

## [1.50](https://code.visualstudio.com/updates/v1_50)
 ![](https://img.shields.io/badge/-september_2020-informational)

- Append new file extension associations.
  - C++ source code: *c++*
  - C++ header file: *h++*

  See the [source code](https://github.com/microsoft/vscode/blob/1.50.0/build/lib/electron.ts#L49).

## [1.59](https://code.visualstudio.com/updates/v1_59)
 ![](https://img.shields.io/badge/-july_2021-informational)

- Append new file extension associations.
  - Lockfile: *lock*

  See the [source code](https://github.com/microsoft/vscode/blob/1.59.0/build/lib/electron.ts#L148)

## [1.60](https://code.visualstudio.com/updates/v1_60)
 ![](https://img.shields.io/badge/-august_2021-informational)

- Append new file extension associations.
  - Configuration file: *cfg*
  - HTML: *xhtml*
  - Python script: *pyi*
  - Ruby source code: *erb*
  - SASS file: *sass*
  - XML: *plist*
  - Comma Separated Values: *csv*
  - CMake script: *cmake*
  - Dart script: *dart*
  - Diff file: *diff*
  - Gradle file: *gradle*
  - Groovy script: *groovy*
  - Makefile: *mk*
  - Jupyter: *ipynb*
  - Log file: *log*
  - Restructured Text document: *rst*
  - LaTeX document: *tex*, *cls*
  - TOML document: *toml*

  See the [source code](https://github.com/microsoft/vscode/blob/1.60.0/build/lib/electron.ts#L102-L176)

## [1.71](https://code.visualstudio.com/updates/v1_17)
 ![](https://img.shields.io/badge/-august_2022-informational)

- Append new file extension associations.
  - Swift source code: *swift*

  See the [source code](https://github.com/microsoft/vscode/blob/1.71.0/build/lib/electron.ts#L170)
