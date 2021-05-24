import IDefaultResponseDto from './IDefaultResponseDto';

export default class DefaultResponseDto {
    public static getErrorFromMessage(reason: string, statusCode: number): IDefaultResponseDto {
        return {
            message: reason,
            status: statusCode.toString()
        };
    }
}
