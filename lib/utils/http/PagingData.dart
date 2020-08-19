/// @author DeMon
/// Created on 2020/8/18.
/// E-mail 757454343@qq.com
/// Desc: 
class PagingData {
  int curPage;
  List<dynamic> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  PagingData(
      {this.curPage,
        this.datas,
        this.offset,
        this.over,
        this.pageCount,
        this.size,
        this.total});

  PagingData.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    if (json['datas'] != null) {
      datas = new List<dynamic>();
      json['datas'].forEach((v) {
        datas.add(v);
      });
    }
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }
}
