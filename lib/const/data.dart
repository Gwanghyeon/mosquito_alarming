const serviceKey =
    'W4xgYF5CSNZPmdn6asB3i5XLCkLjPqQTey0ck2AbcvxZ3EtmjiV58JjhoyU0WV4aOqOuSzjXyRLqRo8kEp6img==';
const weatherWebUrl =
    'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst';

const OSONG = [66, 106];
const SEOUL = [60, 127];
const ULSAN = [100, 84];
const JEJU = [48, 36];

const TEMP_CODE = 'TMP';
const RAIN_CODE = 'PCP';

const REGION = ['서울', '오송', '울산', '제주'];

const Map<String, double> SEOUL_DATA = {'temp': 34, 'rainFall': 0};
const Map<String, double> OSONG_DATA = {'temp': 28, 'rainFall': 0};
const Map<String, double> ULSAN_DATA = {'temp': 20, 'rainFall': 18};
const Map<String, double> JEJU_DATA = {'temp': 15, 'rainFall': 0};

const List<String> LEVEL_TEXT = [
  '편히 야외 활동 하세요',
  '조금 주의하시길 바래요',
  '모기가 윙윙 날아다닐 수 있어요',
  '모기퇴치제로 샤워하세요!'
];

const List<String> LEVEL_STAGE = [
  '쾌적',
  '관심',
  '주의',
  '불쾌',
];
