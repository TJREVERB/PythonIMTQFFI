cdef extern from "imtq-config.h":
  ctypedef union imtq_config_value:
      int8_t int8_val;                /**< Storage for signed single-byte values */
      uint8_t uint8_val;              /**< Storage for unsigned single-byte values */
      int16_t int16_val;              /**< Storage for signed byte-pair values */
      uint16_t uint16_val;            /**< Storage for unsigned byte-pair values */
      int32_t int32_val;              /**< Storage for signed four-byte values */
      uint32_t uint32_val;            /**< Storage for unsigned four-byte values */
      float float_val;                /**< Storage for IEEE754 single-precision floating point values (four bytes) */
      int64_t int64_val;              /**< Storage for signed eight-byte values */
      uint64_t uint64_val;            /**< Storage for unsigned eight-byte values */
      double double_val            /**< Storage for IEEE754 double-precision floating point values (eight bytes) */
  ctypedef struct __attribute__((packed)) imtq_config_resp:
      imtq_resp_header hdr;           /**< Response message header */
      uint16_t param;                 /**< Echo of requested parameter ID */
      imtq_config_value value        /**< Current value of requested parameter */
  KADCSStatus k_adcs_configure(const JsonNode * config)
  KADCSStatus k_imtq_get_param(uint16_t param, imtq_config_resp * response)
  KADCSStatus k_imtq_set_param(uint16_t param, const imtq_config_value * value, imtq_config_resp * response)
  KADCSStatus k_imtq_reset_param(uint16_t param, imtq_config_resp * response)
cdef extern from "imtq-data.h":
  ctypedef enum ADCSTelemType:
      NOMINAL,                    /**< System state, all system measurements */
      DEBUG                       /**< System state, current configuration, last test results */
  ctypedef uint32_t   adcs_power_status;
  ctypedef struct __attribute__((packed)) imtq_state:
      imtq_resp_header hdr;       /**< Response message header */
      uint8_t mode;               /**< Current system mode */
      uint8_t error;              /**< Error encountered during previous interation */
      uint8_t config;             /**< Parameter updated since system startup? 0 - No, 1 - Yes */
      uint32_t uptime          /**< System uptime in seconds */
  
