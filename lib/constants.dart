class Constant {
  static final String url = "http://192.168.43.213:8000";
  static final String baseUrl = "${url}/api";

  static List<String> fakultasList = [
    "FISIP",
    "FEB",
    "TEKNIK",
    "PSIKOLOGI",
  ];
  static Map<String, List<String>> prodiList = {
    "FISIP": ["Ilmu Komunikasi", "Administrasi Bisnis", "Administrasi Pubilk"],
    "FEB": ["Ekonomi Manajemen", "Ekonomi Pembangunan", "Ekonomi Akuntansi"],
    "TEKNIK": [
      "Teknik Informatika",
      "Teknik Industri",
      "Teknik Mesin",
      "Teknik Sipil",
      "Teknik Elektro",
      "Teknik Arsitektur"
    ],
    "PSIKOLOGI": ["Psikologi"]
  };
}
