# Primer3 Parameters

module Qu
  module Pcr
    PRIMER3_OPTIONS = {
      SEQUENCE_ID: "",
      SEQUENCE_TARGET: "",
      SEQUENCE_EXCLUDED_REGION: "",
      SEQUENCE_FORCE_LEFT_START: -1000000,
      SEQUENCE_FORCE_LEFT_END: -1000000,
      SEQUENCE_FORCE_RIGHT_START: -1000000,
      SEQUENCE_FORCE_RIGHT_END: -1000000,
      SEQUENCE_PRIMER: '',
      SEQUENCE_PRIMER_REVCOMP: '',
      PRIMER_PRODUCT_SIZE_RANGE: '100-200 200-300 300-400 400-500',
      PRIMER_MIN_SIZE: 18,
      PRIMER_OPT_SIZE: 22,
      PRIMER_MAX_SIZE: 28,
      PRIMER_MIN_TM: 55,
      PRIMER_OPT_TM: 60,
      PRIMER_MAX_TM: 65,
      PRIMER_MIN_GC: 40,
      PRIMER_OPT_GC: 50,
      PRIMER_MAX_GC: 60,
      PRIMER_MAX_POLY_X: 4,
      PRIMER_MAX_HAIRPIN_TH: 47,
      PRIMER_MAX_SELF_ANY_TH: 47,
      PRIMER_MAX_SELF_END_TH: 47,
      SEQUENCE_TEMPLATE: "",
      PRIMER_THERMODYNAMIC_PARAMETERS_PATH: Cmdwrapper::THERMO_PATH,
      PRIMER_PICK_LEFT_PRIMER: 1,
      PRIMER_PICK_INTERNAL_OLIGO: 0,
      PRIMER_PICK_RIGHT_PRIMER: 1,
      PRIMER_NUM_RETURN: 10,
      PRIMER_MAX_NS_ACCEPTED: 0,
      # PRIMER_THERMODYNAMIC_ALIGNMENT: 1, # not available since release 2.3.5 2013-01-03
      PRIMER_THERMODYNAMIC_OLIGO_ALIGNMENT: 1,
      PRIMER_THERMODYNAMIC_TEMPLATE_ALIGNMENT: 1,
      PRIMER_TM_FORMULA: 1,
      PRIMER_SALT_CORRECTIONS: 1,
      PRIMER_SALT_MONOVALENT: 50.0,
      PRIMER_SALT_DIVALENT: 1.5,
      PRIMER_DNTP_CONC: 0.25,
      PRIMER_DNA_CONC: 50.0,
      P3_FILE_FLAG: 0,
      PRIMER_EXPLAIN_FLAG: 1,
      PRIMER_PRODUCT_MAX_TM: 100000,
      PRIMER_PICK_ANYWAY: 0,
      PRIMER_TASK: "generic",
      SEQUENCE_PRIMER_PAIR_OK_REGION_LIST: "",
      PRIMER_MIN_LEFT_THREE_PRIME_DISTANCE: 2,
      PRIMER_LOWERCASE_MASKING: 1,
    }

    # Parameters not shown to users for editing
    USER_SPECIFIC_OPTIONS = [
			:SEQUENCE_ID,
			:SEQUENCE_TARGET,
			:SEQUENCE_EXCLUDED_REGION,
			:SEQUENCE_FORCE_LEFT_START,
			:SEQUENCE_FORCE_LEFT_END,
			:SEQUENCE_FORCE_RIGHT_START,
			:SEQUENCE_FORCE_RIGHT_END,
			:SEQUENCE_PRIMER,
			:SEQUENCE_PRIMER_REVCOMP,
			:PRIMER_PRODUCT_SIZE_RANGE,
			:PRIMER_MIN_SIZE,
			:PRIMER_OPT_SIZE,
			:PRIMER_MAX_SIZE,
			:PRIMER_MIN_TM,
			:PRIMER_OPT_TM,
			:PRIMER_MAX_TM,
			:PRIMER_MIN_GC,
			:PRIMER_OPT_GC,
			:PRIMER_MAX_GC,
			:PRIMER_MAX_POLY_X,
			:PRIMER_MAX_HAIRPIN_TH,  # I think it's no needed here, becuse they should be checked in MFEprimer (>v3.0), Wubin Qu [2014-5-8]
			:PRIMER_MAX_SELF_ANY_TH,
			:PRIMER_MAX_SELF_END_TH,
    ]
  end
end