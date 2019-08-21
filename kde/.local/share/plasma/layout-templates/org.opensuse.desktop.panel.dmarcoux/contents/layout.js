var panel = new Panel;
var panelScreen = panel.screen;

panel.location = "top";
panel.height = gridUnit * 2;

// TODO: All widgets are configured in the plasmoidsetupscripts directory of a "Look and Feel" theme
panel.addWidget("org.kde.plasma.kickoff");
panel.addWidget("org.kde.plasma.pager");
panel.addWidget("org.kde.plasma.taskmanager");
panel.addWidget("org.kde.plasma.systemtray");
var digitalClock= panel.addWidget("org.kde.plasma.digitalclock");
digitalClock.currentConfigGroup = ["Appearance"];
digitalClock.writeConfig("showDate", true);
digitalClock.writeConfig("showSeconds", true);
digitalClock.writeConfig("dateFormat", "longDate");
