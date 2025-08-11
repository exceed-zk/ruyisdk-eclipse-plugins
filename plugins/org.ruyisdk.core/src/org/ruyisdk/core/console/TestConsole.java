package org.ruyisdk.core.console;

public class TestConsole {

    public static void main(String[] args) {
        // 在任何插件中直接调用
        RuyiSdkConsole.getInstance().logInfo("Device connected successfully");
        RuyiSdkConsole.getInstance().logError("Failed to flash device");

        // 快捷显示控制台（首次调用会自动创建）
        ConsoleManager.showConsole();
    }
}
