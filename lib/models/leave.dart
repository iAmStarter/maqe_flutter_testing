// To parse this JSON data, do
//
//     final leave = leaveFromJson(jsonString);

import 'dart:convert';

class Leave {
  Leave({
    this.totalDay,
    this.totalDayLeft,
    this.totalDayUsed,
    this.leaveRequests,
  });

  int? totalDay;
  int? totalDayLeft;
  int? totalDayUsed;
  List<LeaveRequest>? leaveRequests;

  factory Leave.fromRawJson(String str) => Leave.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Leave.fromJson(Map<String, dynamic> json) => Leave(
        totalDay: json["total_day"],
        totalDayLeft: json["total_day_left"],
        totalDayUsed: json["total_day_used"],
        leaveRequests: json["leave_requests"] == null
            ? null
            : List<LeaveRequest>.from(
                json["leave_requests"].map((x) => LeaveRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_day": totalDay,
        "total_day_left": totalDayLeft,
        "total_day_used": totalDayUsed,
        "leave_requests": leaveRequests == null
            ? null
            : List<dynamic>.from(leaveRequests!.map((x) => x.toJson())),
      };
}

class LeaveRequest {
  LeaveRequest({
    this.status,
    this.requestList,
  });

  String? status;
  List<RequestList>? requestList;

  factory LeaveRequest.fromRawJson(String str) =>
      LeaveRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeaveRequest.fromJson(Map<String, dynamic> json) => LeaveRequest(
        status: json["status"],
        requestList: json["request_list"] == null
            ? null
            : List<RequestList>.from(
                json["request_list"].map((x) => RequestList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "request_list": requestList == null
            ? null
            : List<dynamic>.from(requestList!.map((x) => x.toJson())),
      };
}

class RequestList {
  RequestList({
    this.date,
    this.type,
  });

  DateTime? date;
  String? type;

  factory RequestList.fromRawJson(String str) =>
      RequestList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestList.fromJson(Map<String, dynamic> json) => RequestList(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "type": type,
      };
}
