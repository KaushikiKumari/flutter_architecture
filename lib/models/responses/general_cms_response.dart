// ignore_for_file: unnecessary_new, unnecessary_this, unnecessary_null_comparison

class GeneralCmsResponse {
  late int status;
  late String message;
  late GeneralCmsData data;

  GeneralCmsResponse(
      {required this.status, required this.message, required this.data});

  GeneralCmsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = GeneralCmsData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class GeneralCmsData {
  late String pageCode;
  late String pageTitle;
  late String pageContent;
  late String videoPath;

  GeneralCmsData(
      {required this.pageCode,
      required this.pageTitle,
      required this.pageContent,
      required this.videoPath});

  GeneralCmsData.fromJson(Map<String, dynamic> json) {
    pageCode = json['page_code'];
    pageTitle = json['page_title'];
    pageContent = json['page_content'];
    videoPath = json['video_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_code'] = this.pageCode;
    data['page_title'] = this.pageTitle;
    data['page_content'] = this.pageContent;
    data['video_path'] = this.videoPath;
    return data;
  }
}
