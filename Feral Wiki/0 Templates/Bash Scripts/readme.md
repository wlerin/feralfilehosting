
# Bash Script updater template.

Bash script updater.

This bash script update/updater templates deals with updating a single file, the `~/bin/somescript`, by updating and switching to this script.

There are two implementations of this template. `update.sh` and `menu.sh`. They are identical except for:

`update.sh` is designed to be linear script, a to b.

`menu.sh` is designed to be an interactive looping menu until the use exits.

**1:** A `wget` command is used to download the github hosted script somewhere on your server.

**2:** When run without bypassing the built in updater the script will compare itself against the github version and update in place if needed.

**3:** The script will then move and rename itself to the `~/bin` directory using then name define in the `$scriptname` variable and be executable. So for example `~/bin/install.somecript`

So how do I use and customise this updater template with my script?

Basic Info section:
---

**1:** Optional - fill in the basic info section at the start for those reading the script code.

**2:** Most of the important information and usage directions are meant to be set in the script info section and used with the script option info. So set them there if required.

Version History Section:
---

**3:** Modify the version history templates in the Version History section and uncomment on a per line basis to use with the script option `changelog`, for example, `somescript changelog`

Variables Section:
---

**4:** `scriptversion="0.0.0"` - replace `0.0.0` with your script version. This will be shown to the user at the current version check.

**5:** `scriptname="somescript"` - replace `somescript` with your script name. Make it unique to this script. Do not include the file extension.

**6:** `scriptauthor="None credited"` - change this to the script author's name.

**7:** `contributors="None credited"` - add the names of any contributors you wish to credit here.

**8:** `gitiourl="http://git.io/vvf9K"` - change this to the shortened URL provided by [http://git.io](http://git.io) once you have committed the script to github or from a gist.

**9:** `gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"` - Leave this as it is. Do not modify it. This variable depends on the correct setting of the `$gitiourl` variable.

**10:**` scripturl="https://raw.github.com/feralhosting"` - Set the scripturl variable in the variable section to the RAW github URL of the script for use with the updater features.

**11:** `appport="$(shuf -i 10001-32001 -n 1)"` - works in tandem with a while loop just below it. Will generate and test a port to make sure it is not in use. Use this when configuring an application's port.

**12:** `updaterenabled="1"` - Set this to `0` to permanently disable the built in updater and associated features.

Variables Section: Custom Variables
---

**13:** Place your custom variables here. They can be used in the help option of the script.

Functions Section:
---

**Menu Template specific: **`options1`,`options2`,`options3` are the option descriptions in the script. If you add more option you also need to modify the menu entry in the script to match. See `option4`,`option5`,`option6` as examples to modify.

**14:** Place your custom functions here. Your functions will be able to make use of variables sections in this location. There is an example function in this section.

Script Help Section:
---

**15:** Place your help information and usage instructions inside the section labelled `Custom Script Notes` using echoes.

Script Info Section:
---

> **Important note:** The info section contains basic information about the features of this updater and the script. Don't modify these. You have a section dedicated to your unique information.

**16:** Place your unique information and usage instructions inside the section labelled "Custom Script Notes" using echoes.

Self Updater Section:
---

**17:** This section is self contained you don't need to modify this section. This feature will compare itself vs the raw script linked at the github URL provided and update itself

Positional Param Section:
---

> **Important note:** use `somescript example` or `somescript example test` to load the example.

This section comes after the built in updater and your parameters will survive if the script updates when called.

**18:** Place your custom positional parameters in this section. They will load after the main updater to make sure they are current.

User Scripts:
---

> **Important Note:** This template is a wrapper around your script. You will need to make use of the script option below like `qr` to call your own options.

**19:** Insert your script in the "User Script" labelled section - Indented by one tab (4 spaces) to be in line with the overall script. You can copy and paste a working script into this section.

Script Options explained:
---

**20:** `changelog` - use the argument qr when calling the script, for example - `somescript changelog`.

**22:** `help` - Use this section to create help notes and usage instructions for the user when they use this option, for example - `somescript help`.

**23:** `info` - use the argument qr when calling the script, for example - `somescript info`.

**24:** `qr` - use this option to quick run the script suppressing all update prompts and jumping directly to the user script, for example - `somescript qr`. Note - This does not disable or bypass the updater.

**25:** `nu` - use the option to disable the update features of the script, for example - `somescript nu`. Note - This will run the script from where it is called and append `-DEV` to the version number output.
