export default interface IMedicineAlarm {
    ID_PATIENT: number;
    id: string;
    title: string;
    alarmDateTime: Date;
    isPending: string;
}