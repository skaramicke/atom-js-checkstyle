#The Changelog

##0.12.0
* Bug Fix: GH-15 - escape file paths. Thanks to [Percy Hatcherson](https://github.com/primitive-type) for the patch
* Ability to toggle list view on|off

##0.11.0
* Ability to toggle gutter marks on|off. [Implements GH-14](https://github.com/benmatselby/atom-js-checkstyle/issues/14)

##0.10.0
* Structural changes to decouple app from views
* Decoupled gutter view with list view
* Ability to have the error displayed just above the status bar. [Implements GH-11](https://github.com/benmatselby/atom-js-checkstyle/issues/11)

##0.9.0
* Do not show list view if file is clean. Thanks to [postcasio](https://github.com/postcasio).

##0.8.0
* Ability to sniff on save [Implements GH-2](https://github.com/benmatselby/atom-js-checkstyle/issues/2)
* Ability to toggle execution on save

##0.7.0
* Render gutter marks for sniffer errors
* Ability to toggle gutter marks on|off
* Ability to toggle jscs execution on|off when sniffing file
* Ability to toggle jsmd execution on|off when sniffing file
* Ability to toggle the linter when sniffing file
* Pulled out controller methods into PhpCheckstyle class
* Entry point moved to main.coffee and updated package.json

##0.6.1
* Fixed sorting bug by implementing getFilterKey

##0.6.0
* Fixed [GH-7](https://github.com/benmatselby/atom-js-checkstyle/issues/7), which is to unescape html entities for list view. Thanks to [Ciaran Downey](https://github.com/ciarand).
* Started to follow GH coding standard for coffeescript

##0.5.0
* Display what has been fixed by js-cs-fixer
* Display a message to say nothing was fixed by the js-cs-fixer, if no changes were made
* Created a base view and moved most of the common code there (work in progress)

##0.4.2
* Add verbosity to js-cs-fixer command until I figure out a UI mechanism to display success|fail
* Define multiple scope names for JS, as suspect they may change based on open issues in language-js

##0.4.1
* Fixed js-cs-fixer command being broken by shell accepting an array of commands

##0.4.0
* Linter functionality has been added
* Mess Detector functionality has been added

##0.3.0
* Ability to "Fix" a file using [JS CS Fixer](http://cs.sensiolabs.org/)
* Tidied up the naming convention in the menus
* Ability to select a sniffer error from the list and be taken to the line it has occurred

##0.2.0
* Now has configuration options for jscs thanks to [Phil Sturgeon](https://github.com/philsturgeon)
* Now displays the line number alongside the error message in the list view

##0.1.0
* Initial release, only really runs the jscs and tries to report
