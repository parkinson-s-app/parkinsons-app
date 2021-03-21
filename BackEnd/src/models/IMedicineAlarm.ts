export default interface IMedicineAlarm {
    ID_PATIENT: number;
    id: string;
    title: string;
    alarmDateTime: string;
    alarmTime: string;
    isPending: boolean;
}