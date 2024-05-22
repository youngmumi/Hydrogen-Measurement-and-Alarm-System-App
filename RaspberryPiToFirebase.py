
import spidev
import time
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

spi = spidev.SpiDev()
spi.open(0, 0)
spi.max_speed_hz = 1000000

# Firebase 서비스 계정 키 로드
cred = credentials.Certificate('/home/yongwoogu/firebase/hydrogen-on-firebase-firebase-adminsdk-z0jc6-5a8400bfd5.json')
firebase_admin.initialize_app(cred, {'databaseURL': 'https://hydrogen-on-firebase-default-rtdb.firebaseio.com/'})

def read_mq(channel):
    adc_value = spi.xfer2([1, (8 + channel) << 4, 0])
    mq_value = ((adc_value[1] & 3) << 8) + adc_value[2]
    return mq_value

try:
    mq_values = []
    while True:
        channel = 0
        mq_value = read_mq(channel)
        mq_values.append(mq_value)
        
        print("H2 Gas:", mq_value)
        
        # Firebase Realtime Database에 데이터 저장
        key = 'gas_data'  # 원하는 키 값을 지정
        ref = db.reference('/gas_data')
        ref.child(key).set({
            'gas_value': mq_value,
            'timestamp': time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())
        })
        
        if len(mq_values) >= 10:
            max_value = max(mq_values)
            min_value = min(mq_values)
            diff = max_value - min_value
            print("H2 Gas Rate:", diff)
            
            ref = db.reference('/gas_sensor')
            ref.push().set({'gas_rate': diff})
            
            mq_values = []
        
        time.sleep(0.001)

except KeyboardInterrupt:
    spi.close()
