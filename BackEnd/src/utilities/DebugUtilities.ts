export class DebugUtilities {
    public static getMessage(reason: any): string {
        if (reason instanceof Error) {
            return reason.message;
        } else {
            return reason;
        }
    }
}
