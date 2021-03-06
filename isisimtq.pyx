from libc.stdint cimport uint8_t, uint16_t, uint32_t, uint64_t, int8_t, int16_t, int32_t, int64_t
from libcpp cimport bool
cdef extern from "json.h":
    ctypedef enum JsonTag:
        JSON_NULL,
        JSON_BOOL,
        JSON_STRING,
        JSON_NUMBER,
        JSON_ARRAY,
        JSON_OBJECT
    ctypedef struct JsonNode
	
  #ctypedef struct JsonNode:
    #/* only if parent is an object or array (NULL otherwise) */
    #JsonNode *parent;
    #JsonNode *prev, *next;
	
    #/* only if parent is an object (NULL otherwise) */
    #char *key; #/* Must be valid UTF-8. */
	
    #JsonTag tag;
    #union {
	    #/* JSON_BOOL */
        #bool bool_;
		
	    #/* JSON_STRING */
        #char *string_; #/* Must be valid UTF-8. */
		
	    #/* JSON_NUMBER */
        #double number_;
		
	    #/* JSON_ARRAY */
	    #/* JSON_OBJECT */
        #struct children: 
            #JsonNode *head, *tail;
     #};  
	
cdef extern from "imtq-config.h":
  cdef extern from "json.h":
    ctypedef enum JsonTag:
        JSON_NULL,
        JSON_BOOL,
        JSON_STRING,
        JSON_NUMBER,
        JSON_ARRAY,
        JSON_OBJECT
    ctypedef struct JsonNode
  ctypedef union imtq_config_value:
      int8_t int8_val;                #*< Storage for signed single-byte values */
      uint8_t uint8_val;              #*< Storage for unsigned single-byte values */
      int16_t int16_val;              #*< Storage for signed byte-pair values */
      uint16_t uint16_val;            #*< Storage for unsigned byte-pair values */
      int32_t int32_val;              #*< Storage for signed four-byte values */
      uint32_t uint32_val;            #*< Storage for unsigned four-byte values */
      float float_val;                #*< Storage for IEEE754 single-precision floating point values (four bytes) */
      int64_t int64_val;              #*< Storage for signed eight-byte values */
      uint64_t uint64_val;            #*< Storage for unsigned eight-byte values */
      double double_val            #*< Storage for IEEE754 double-precision floating point values (eight bytes) */
  ctypedef struct imtq_resp_header:
      uint8_t cmd;
      uint8_t status;
  ctypedef struct imtq_config_resp:
      imtq_resp_header hdr;           #*< Response message header */
      uint16_t param;                 #*< Echo of requested parameter ID */
      imtq_config_value value        #*< Current value of requested parameter */
  KADCSStatus k_adcs_configure(const JsonNode * config)
  KADCSStatus k_imtq_get_param(uint16_t param, imtq_config_resp * response)
  KADCSStatus k_imtq_set_param(uint16_t param, const imtq_config_value * value, imtq_config_resp * response)
  KADCSStatus k_imtq_reset_param(uint16_t param, imtq_config_resp * response)
cdef extern from "imtq-data.h":
  ctypedef enum ADCSTelemType:
      NOMINAL,                    #*< System state, all system measurements */
      DEBUG                       #*< System state, current configuration, last test results */
  ctypedef struct  imtq_axis_data:
    int16_t x;                  #*< X-axis */
    int16_t y;                  #*< Y-axis */
    int16_t z                  #*< Z-axis */
  ctypedef uint32_t   adcs_power_status
  ctypedef struct imtq_state:
      imtq_resp_header hdr;       #*< Response message header */
      uint8_t mode;               #*< Current system mode */
      uint8_t error;              #*< Error encountered during previous interation */
      uint8_t config;             #*< Parameter updated since system startup? 0 - No, 1 - Yes */
      uint32_t uptime          #*< System uptime in seconds */
  ctypedef struct imtq_mtm_data:
    int32_t x;                  #*< X-axis */
    int32_t y;                  #*< Y-axis */
    int32_t z                 #*< Z-axis */
  ctypedef struct imtq_mtm_msg:
    imtq_resp_header hdr;        #*< Response message header */
    imtq_mtm_data data;          #*< MTM measurement data. Units dependent on function used */
    uint8_t act_status         #*< Coils actuation status during measurement. 0 - Not actuating, 1 - Actuating */
  ctypedef struct imtq_axis_msg:
    imtq_resp_header hdr;                #*< Response message header */
    imtq_axis_data data                 #*< Axes data */
  ctypedef imtq_axis_msg imtq_coil_current  #*< Coil currents in [10<sup>-4</sup> A] returned by ::k_imtq_get_coil_current */
  ctypedef imtq_axis_msg imtq_coil_temp     #*< Coil temperatures in [<sup>o</sup>C] returned by ::k_imtq_get_coil_temps */
  ctypedef imtq_axis_msg imtq_dipole
  ctypedef struct imtq_test_result:
    imtq_resp_header hdr;                #*< Response message header */
    uint8_t error;                       #*< Return code for the step */
    uint8_t step;                        #*< Axis being tested */
    imtq_mtm_data mtm_raw;               #*< Raw MTM data in [7.5*10<sup>-9</sup> T] per count */
    imtq_mtm_data mtm_calib;             #*< Calibrated MTM data in [10<sup>-9</sup> T] */
    imtq_axis_data coil_current;         #*< Coil currents in [10<sup>-4</sup> A] */
    imtq_axis_data coil_temp            #*< Coil temperatures in [<sup>o</sup>C] */
  ctypedef struct imtq_test_result_single:
    imtq_test_result init;               #*< Measurements before actuation */
    imtq_test_result step;               #*< Measurements during actuation of requested axis */
    imtq_test_result final              #*< Measurements after actuation */
  ctypedef struct imtq_test_result_all:
    imtq_test_result init;               #*< Measurements before actuation */
    imtq_test_result x_pos;              #*< Measurements during actuation of positive x-axis */
    imtq_test_result x_neg;              #*< Measurements during actuation of negative x-axis */
    imtq_test_result y_pos;              #*< Measurements during actuation of positive y-axis */
    imtq_test_result y_neg;              #*< Measurements during actuation of negative y-axis */
    imtq_test_result z_pos;              #*< Measurements during actuation of positive z-axis */
    imtq_test_result z_neg;              #*< Measurements during actuation of negative z-axis */
    imtq_test_result final              #*< Measurements after actuation */
  ctypedef struct imtq_detumble:
    imtq_resp_header hdr;                #*< Response message header */
    imtq_mtm_data mtm_calib;             #*< Calibrated MTM data in [10<sup>-9</sup> T] */
    imtq_mtm_data mtm_filter;            #*< Filtered MTM data in [10<sup>-9</sup> T] */
    imtq_mtm_data bdot;                  #*< B-Dot in [10<sup>-9</sup> T*s<sup>-1</sup>] */
    imtq_axis_data dipole;               #*< Commanded actuation dipole in [10<sup>-4</sup> Am<sup>2</sup>] */
    imtq_axis_data cmd_current;          #*< Command current in [10<sup>-4</sup> A] */
    imtq_axis_data coil_current         #*< Coil currents in [10<sup>-4</sup> A] */
  ctypedef struct imtq_axis_data_raw:
    int16_t x;                          #*< X-axis */
    int16_t y;                          #*< Y-axis */
    int16_t z                          #*< Z-axis */
  ctypedef struct imtq_housekeeping_raw:
    imtq_resp_header hdr;               #*< Response message header */
    uint16_t voltage_d;                 #*< Digital supply voltage */
    uint16_t voltage_a;                 #*< Analog supply voltage */
    uint16_t current_d;                 #*< Digital supply current */
    uint16_t current_a;                 #*< Analog supply current */
    imtq_axis_data_raw coil_current;    #*< Coil currents */
    imtq_axis_data_raw coil_temp;       #*< Coil temperatures */
    uint16_t mcu_temp                  #*< MCU temperature */
  ctypedef struct imtq_housekeeping_eng:
    imtq_resp_header hdr;               #*< Response message header */
    uint16_t voltage_d;                 #*< Digital supply voltage in [mV] */
    uint16_t voltage_a;                 #*< Analog supply voltage in [mV] */
    uint16_t current_d;                 #*< Digital supply current in [10<sup>-4</sup> A] */
    uint16_t current_a;                 #*< Analog supply current in [10<sup>-4</sup> A] */
    imtq_axis_data coil_current;        #*< Coil currents in [10<sup>-4</sup> A] */
    imtq_axis_data coil_temp;           #*< Coil temperatures in [<sup>o</sup>C] */
    int16_t mcu_temp                  #*< MCU temperature in [<sup>o</sup>C] */
  ctypedef struct adcs_orient
  ctypedef struct adcs_spin
  KADCSStatus k_adcs_get_power_status(adcs_power_status * data)
  KADCSStatus k_adcs_get_mode(ADCSMode * mode)
  KADCSStatus k_adcs_get_orientation(adcs_orient * data)
  KADCSStatus k_adcs_get_spin(adcs_spin * data)
  KADCSStatus k_adcs_get_telemetry(ADCSTelemType type, JsonNode * buffer)
  KADCSStatus k_imtq_get_system_state(imtq_state * state)
  KADCSStatus k_imtq_get_raw_mtm(imtq_mtm_msg * data)
  KADCSStatus k_imtq_get_calib_mtm(imtq_mtm_msg * data)
  KADCSStatus k_imtq_get_coil_current(imtq_coil_current * data)
  KADCSStatus k_imtq_get_coil_temps(imtq_coil_temp * data)
  KADCSStatus k_imtq_get_dipole(imtq_dipole * data)
  KADCSStatus k_imtq_get_test_results_single(imtq_test_result_single * data)
  KADCSStatus k_imtq_get_test_results_all(imtq_test_result_all * data)
  KADCSStatus k_imtq_get_detumble(imtq_detumble * data)
  KADCSStatus k_imtq_get_raw_housekeeping(imtq_housekeeping_raw * data)
  KADCSStatus k_imtq_get_eng_housekeeping(imtq_housekeeping_eng * data)
  KADCSStatus kprv_adcs_get_status_telemetry(JsonNode * buffer)
  KADCSStatus kprv_adcs_get_nominal_telemetry(JsonNode * buffer)
  KADCSStatus kprv_adcs_get_debug_telemetry(JsonNode * buffer)
  void kprv_adcs_process_test(JsonNode * parent, imtq_test_result test)
cdef extern from "imtq-ops.h": 
  ctypedef enum KADCSReset:
    SOFT_RESET      #*< Software reset */
  ctypedef enum ADCSTestType:
    TEST_ALL,        #*< Test all axes */
    TEST_X_POS,      #*< Test positive x-axis */
    TEST_X_NEG,      #*< Test negative x-axis */
    TEST_Y_POS,      #*< Test positive y-axis */
    TEST_Y_NEG,      #*< Test negative y-axis */
    TEST_Z_POS,      #*< Test positive z-axis */
    TEST_Z_NEG       #*< Test negative z-axis */
  ctypedef uint16_t   adcs_mode_param
  ctypedef JsonNode * adcs_test_results
  KADCSStatus k_adcs_noop()
  KADCSStatus k_adcs_reset(KADCSReset type)
  KADCSStatus k_adcs_set_mode(ADCSMode mode, const adcs_mode_param * params)
  KADCSStatus k_adcs_run_test(ADCSTestType test, adcs_test_results buffer)
  KADCSStatus k_imtq_cancel_op()
  KADCSStatus k_imtq_start_measurement()
  KADCSStatus k_imtq_start_actuation_current(imtq_axis_data current, uint16_t       time)
  KADCSStatus k_imtq_start_actuation_dipole(imtq_axis_data dipole, uint16_t time)
  KADCSStatus k_imtq_start_actuation_PWM(imtq_axis_data pwm, uint16_t time)
  KADCSStatus k_imtq_start_test(ADCSTestType axis)
  KADCSStatus k_imtq_start_detumble(uint16_t time)
cdef extern from "imtq.h":
  ctypedef enum KADCSStatus:
    ADCS_OK,
    ADCS_ERROR,                  #*< Generic error */
    ADCS_ERROR_CONFIG,           #*< Configuration error */
    ADCS_ERROR_NO_RESPONSE,      #*< No response received from subsystem */
    ADCS_ERROR_INTERNAL,         #*< An error was thrown by the subsystem */
    ADCS_ERROR_MUTEX,            #*< Mutex-related error */
    ADCS_ERROR_NOT_IMPLEMENTED   #*< Requested function has not been implemented for the subsystem */
  ctypedef enum KIMTQStatus:
    IMTQ_OK,
    IMTQ_ERROR           = 0x01, #*< Generic error */
    IMTQ_ERROR_BAD_CMD   = 0x02, #*< Invalid command */
    IMTQ_ERROR_NO_PARAM  = 0x03, #*< Parameter missing */
    IMTQ_ERROR_BAD_PARAM = 0x04, #*< Parameter invalid */
    IMTQ_ERROR_MODE      = 0x05, #*< Command unavailable in current mode */
    IMTQ_ERROR_RESERVED  = 0x06, #*< (Internal reserved value) */
    IMTQ_ERROR_INTERNAL  = 0x07  #*< Internal error */
  ctypedef struct imtq_resp_header:
    uint8_t cmd;
    uint8_t status;#*< Command which produced this response */
    # *
    # * Status byte
    # *
    # * Contains command response flags, like ::RESP_IVA_X, and a return code
    # * which can be extracted with ::kprv_imtq_check_error
    # */
  ctypedef struct  imtq_axis_data:
    int16_t x;                  #*< X-axis */
    int16_t y;                  #*< Y-axis */
    int16_t z                  #*< Z-axis */
  ctypedef enum ADCSMode:
    IDLE,           #*< Idle mode */
    SELFTEST,       #*< Self-test mode */
    DETUMBLE        #*< Detumble mode */
  ctypedef struct adcs_orient
    # Not an implemented structure/function. Need for compliance with generic API */
  ctypedef struct adcs_spin
    # Not an implemented structure/function. Need for compliance with generic API */
  #ctypedef struct timespec
  KADCSStatus k_adcs_init(char * bus, uint16_t addr, int timeout)
  void k_adcs_terminate()
  KADCSStatus k_imtq_watchdog_start()
  KADCSStatus k_imtq_watchdog_stop()
  KADCSStatus k_imtq_reset()
  #KADCSStatus k_adcs_passthrough(const uint8_t * tx, int tx_len, uint8_t * rx, int rx_len, const timespec * delay)
  #KADCSStatus kprv_imtq_transfer(const uint8_t * tx, int tx_len, uint8_t * rx, int rx_len, const timespec * delay)

def py_k_adcs_init(char * bus, addr, int timeout):
        return k_adcs_init(bus, <uint16_t>addr, timeout)
def py_k_adcs_terminate():
        return k_adcs_terminate()
def py_k_imtq_watchdog_start():
        return k_imtq_watchdog_start()
def py_k_imtq_watchdog_stop():
        return k_imtq_watchdog_stop()
def py_k_imtq_reset():
        return k_imtq_reset()
def py_k_imtq_get_param(param, response):
        return k_imtq_get_param(<uint16_t>param, <imtq_config_resp *>response)
#def py_k_imtq_set_param(param,value,response):
        #return k_imtq_set_param(<uint16_t>param, <const imtq_config_value *>value, <imtq_config_resp *>response)
def py_k_imtq_reset_param(param, response):
        return k_imtq_reset_param(<uint16_t>param, <imtq_config_resp *>response)
#def py_k_adcs_get_power_status(data):
        #return k_adcs_get_power_status(<adcs_power_status *>data)
#def py_k_adcs_get_mode(mode):
        # k_adcs_get_mode(<ADCSMode *>mode)
def py_k_adcs_get_orientation(data):
        return k_adcs_get_orientation(<adcs_orient *>data)
def py_k_adcs_get_spin(data):
        return k_adcs_get_spin(<adcs_spin *>data)
def py_k_adcs_get_telemetry(type, buffer):
        return k_adcs_get_telemetry(<ADCSTelemType>type, <JsonNode *>buffer)
def py_k_imtq_get_system_state(state):
        return k_imtq_get_system_state(<imtq_state *>state)
def py_k_imtq_get_raw_mtm(data):
        return k_imtq_get_raw_mtm(<imtq_mtm_msg *>data)
def py_k_imtq_get_calib_mtm(data):
        return k_imtq_get_calib_mtm(<imtq_mtm_msg *>data)
def py_k_imtq_get_coil_current(data):
        return k_imtq_get_coil_current(<imtq_coil_current *>data)
def py_k_imtq_get_coil_temps(data):
        return k_imtq_get_coil_temps(<imtq_coil_temp *>data)
def py_k_imtq_get_dipole(data):
        return k_imtq_get_dipole(<imtq_dipole *>data)
def py_k_imtq_get_test_results_single(data):
        return k_imtq_get_test_results_single(<imtq_test_result_single *>data)
def py_k_imtq_get_test_results_all(data):
        return k_imtq_get_test_results_all(<imtq_test_result_all *>data)
def py_k_imtq_get_detumble(data):
        return k_imtq_get_detumble(<imtq_detumble *>data)
def py_k_imtq_get_raw_housekeeping(data):
        return k_imtq_get_raw_housekeeping(<imtq_housekeeping_raw *>data)
def py_k_imtq_get_eng_housekeeping(data):
        return k_imtq_get_eng_housekeeping(<imtq_housekeeping_eng *>data)
def py_kprv_adcs_get_status_telemetry(buffer):
        return kprv_adcs_get_status_telemetry(<JsonNode *>buffer)
def py_kprv_adcs_get_nominal_telemetry(buffer):
        return kprv_adcs_get_nominal_telemetry(<JsonNode *>buffer)
def py_kprv_adcs_get_debug_telemetry(buffer):
        return kprv_adcs_get_debug_telemetry(<JsonNode *>buffer)
def py_kprv_adcs_process_test(parent, test):
        return kprv_adcs_process_test(<JsonNode *>parent, <imtq_test_result>test)
def py_k_adcs_noop():
        return k_adcs_noop()
def py_k_adcs_reset(type):
        return k_adcs_reset(<KADCSReset>type)
#def py_k_adcs_set_mode(mode, params):
        #return k_adcs_set_mode(<ADCSMode>mode, <const adcs_mode_param *>params)
def py_k_adcs_run_test(test, buffer):
        return k_adcs_run_test(<ADCSTestType>test, <adcs_test_results>buffer)
def py_k_imtq_cancel_op():
        return k_imtq_cancel_op()
def py_k_imtq_start_measurement():
        return k_imtq_start_measurement()
def py_k_imtq_start_actuation_current(current, time):
        return k_imtq_start_actuation_current(<imtq_axis_data>current, <uint16_t>time)
def py_k_imtq_start_actuation_dipole(dipole, time):
        return k_imtq_start_actuation_dipole(<imtq_axis_data>dipole, <uint16_t>time)
def py_k_imtq_start_actuation_PWM(pwm, time):
        return k_imtq_start_actuation_PWM(<imtq_axis_data>pwm, <uint16_t>time)
def py_k_imtq_start_test(axis):
        return k_imtq_start_test(<ADCSTestType>axis)
def py_k_imtq_start_detumble(time):
        return k_imtq_start_detumble(<uint16_t>time)

	

