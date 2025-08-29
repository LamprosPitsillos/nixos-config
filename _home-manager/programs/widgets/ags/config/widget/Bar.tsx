import { App, Astal, Gtk, Gdk, astalify,  } from "astal/gtk4"
import { Variable, GLib, bind } from "astal"
import Battery from "gi://AstalBattery"
import Tray from "gi://AstalTray"
import Wp from "gi://AstalWp"
import Network from "gi://AstalNetwork"

function AudioSlider() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!

    return <box cssName="AudioSlider" css="min-width: 140px">
        <image iconName={bind(speaker, "volumeIcon")} />
        <slider
            hexpand
            onNotifyValue={( self  )=> print("new value", self.value)}
            // onDragged={({ value }) => speaker.volume = value}
            value={bind(speaker, "volume")}
        />
    </box>
}

function BatteryLevel() {
    const bat = Battery.get_default()

    return <box cssName="Battery"
        visible={bind(bat, "isPresent")}>
        <image iconName={bind(bat, "batteryIconName")} />
        <label label={bind(bat, "percentage").as(p =>
            `${Math.floor(p * 100)} %`
        )} />
    </box>
}
function SysTray() {
    const tray = Tray.get_default()

    return <box cssName="SysTray">
        {bind(tray, "items").as(items => items.map(item => (
            <menubutton
                tooltipMarkup={bind(item, "tooltipMarkup")}
                usePopover={false}
                actionGroup={bind(item, "action-group").as(ag => ["dbusmenu", ag])}
                menuModel={bind(item, "menu-model")}>
                <image gicon={bind(item, "gicon")} />
            </menubutton>
        )))}
    </box>
}

const time = Variable("").poll(1000, "date")
const Calendar = astalify(Gtk.Calendar)

function Wifi() {
    const network = Network.get_default()
    const wifi = bind(network, "wifi")

    return <box visible={wifi.as(Boolean)}>
        {wifi.as(wifi => wifi && (
            <image
                tooltipText={bind(wifi, "ssid").as(String)}
                cssName="Wifi"
                iconName={bind(wifi, "iconName")}
            />
        ))}
    </box>

}
export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return <window
        visible
        cssClasses={["Bar"]}
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}
        application={App}>
        <centerbox cssName="centerbox">
            <button
                onClicked="echo hello"
                hexpand
                halign={Gtk.Align.CENTER}
            >
                Welcome to AGS!
            </button>
            <box />
            <menubutton
                hexpand
                halign={Gtk.Align.CENTER}
            >
                <label label={time()} />
                <popover>
                    <Calendar onDaySelected={(self) => print(`${self.year}-${self.month+1}-${self.day}`)}/>
                </popover>
            <SysTray/>
            <Wifi/>
            <AudioSlider />
            <BatteryLevel />
            </menubutton>
        </centerbox>
    </window>
}
