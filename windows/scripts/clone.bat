cd ..\..\..\
if not exist webfonts-core (
	git clone https://github.com/pankosmia/webfonts-core.git
)
if not exist resource-core (
	git clone https://github.com/pankosmia/resource-core.git
)
if not exist core-client-content (
	git clone https://github.com/pankosmia/core-client-content.git
)
if not exist core-client-dashboard (
	git clone https://github.com/pankosmia/core-client-dashboard.git
)
if not exist core-client-i18n-editor (
	git clone https://github.com/pankosmia/core-client-i18n-editor.git
)
if not exist core-client-remote-repos (
	git clone https://github.com/pankosmia/core-client-remote-repos.git
)
if not exist core-client-settings (
	git clone https://github.com/pankosmia/core-client-settings.git
)
if not exist core-client-workspace (
	git clone https://github.com/pankosmia/core-client-workspace.git
)
cd desktop-app-liminal\windows\scripts