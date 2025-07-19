import 'pengaduan_pegawai_model.dart';
import 'pagination_model.dart';
import 'tab_counts_model.dart';
import 'current_filter_model.dart';

class PengaduanPegawaiResponseModel {
  final List<PengaduanPegawaiModel> pengaduan;
  final PaginationModel pagination;
  final TabCountsModel tabCounts;
  final CurrentFilterModel currentFilter;

  PengaduanPegawaiResponseModel({
    required this.pengaduan,
    required this.pagination,
    required this.tabCounts,
    required this.currentFilter,
  });

  factory PengaduanPegawaiResponseModel.fromJson(Map<String, dynamic> json) {
    final pengaduanList = (json['pengaduan'] as List)
        .map((item) => PengaduanPegawaiModel.fromJson(item))
        .toList();

    return PengaduanPegawaiResponseModel(
      pengaduan: pengaduanList,
      pagination: PaginationModel.fromJson(json['pagination'] ?? {}),
      tabCounts: TabCountsModel.fromJson(json['tab_counts'] ?? {}),
      currentFilter: CurrentFilterModel.fromJson(json['current_filter'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pengaduan': pengaduan.map((item) => item.toJson()).toList(),
      'pagination': pagination.toJson(),
      'tab_counts': tabCounts.toJson(),
      'current_filter': currentFilter.toJson(),
    };
  }
} 