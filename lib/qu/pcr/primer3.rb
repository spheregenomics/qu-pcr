#!/usr/bin/env ruby

require 'csv'

module Qu
  module Pcr  
    class Primer3
      attr_accessor :para

      def initialize(custom_para=nil)
        @para = {}

        # set default values
        PRIMER3_OPTIONS.each_pair do |opt, value|
          @para[opt] = value
        end

        # set custom value
        unless custom_para.nil?
          custom_para.each_pair do |opt, value|
            @para[opt] = value
          end
        end

      end
      
      def out
        p3_string = create_p3_input()
        p3_input_file = Tempfile.new('p3_input')
        p3_input_file.write(p3_string)
        p3_input_file.close

        p3_out = Cmdwrapper::primer3_core(p3_input_file)

        p3_input_file.unlink

        return Primer3Parser.new(p3_out).records
      end

      private
      def create_p3_input()
        lines = []
        @para.each_pair do |key, value|
          next if value.to_s.empty?
          lines << "#{key}=#{value}"
        end
        lines << "="
        return lines.join("\n")
      end
    end # End Primer3 class

    class Amplicon
      attr_reader :fp, :rp, :product
      def initialize(record, i, type='primer3')
        if type == 'primer3'
          (fp_5_pos, fp_size) = record["PRIMER_LEFT_%s" %[i]].split(',')
          (rp_5_pos, rp_size) = record["PRIMER_RIGHT_%s" %[i]].split(',')
          fp_seq = record["PRIMER_LEFT_%s_SEQUENCE" % [i]]
          rp_seq = record["PRIMER_RIGHT_%s_SEQUENCE" % [i]]
          fp_gc = record["PRIMER_LEFT_%s_GC_PERCENT" % [i]].to_f
          rp_gc = record["PRIMER_RIGHT_%s_GC_PERCENT" % [i]].to_f
          fp_tm = record["PRIMER_LEFT_%s_TM" % [i]].to_f
          rp_tm = record["PRIMER_RIGHT_%s_TM" % [i]].to_f
          product_opt_a = record["PRIMER_PAIR_%s_T_OPT_A" % [i]].to_f
          product_size = record["PRIMER_PAIR_%s_PRODUCT_SIZE" % [i]].to_i
          product_tm = record["PRIMER_PAIR_%s_PRODUCT_TM" % [i]].to_f
          penalty = record["PRIMER_PAIR_%s_PENALTY" % [i]].to_f
          fp_penalty = record["PRIMER_LEFT_%s_PENALTY" % [i]].to_f
          rp_penalty = record["PRIMER_RIGHT_%s_PENALTY" % [i]].to_f   
          id = record["SEQUENCE_ID"].to_s
          product_seq = record["SEQUENCE_TEMPLATE"].to_s[fp_5_pos.to_i..rp_5_pos.to_i]

          @fp = Primer.new(seq = fp_seq,
                           type = 'forward',
                           gc = fp_gc,
                           tm = fp_tm,
                           penalty = fp_penalty,
                           pos = fp_5_pos,
                          )

          @rp = Primer.new(seq = rp_seq,
                           type = 'reverse',
                           gc = rp_gc,
                           tm = rp_tm,
                           penalty = rp_penalty,
                           pos = rp_5_pos,
                          )

          @product = Product.new(seq = product_seq,
                                 tm = product_tm,
                                 opt_a = product_opt_a,
                                 size = product_size,
                                 id = id,
                                 penalty = penalty,
                                )
        end
      end
    end # Amplicon

    class Primer3Parser
      def initialize(p3_out)
        if p3_out.class != String
          $stderr.puts "Need primer3 output file content (not file name) for parsing."
        end
        @p3_out = p3_out
      end

      private
      def parse
        result = []
        if @p3_out.empty?
          return result
        end
        @p3_out.split(/\n=\n/).each do |record|
          record_result = {}
          record.each_line do |line|
            line.strip!
            items = line.split('=')
            record_result[items[0]] = items[1]
          end
          result << record_result
        end

        return result
      end

      public
      def records
        p3_hash = {}
        p3_record = parse
        p3_record.each do |record|
          seq_id = record['SEQUENCE_ID']
          if record.has_key?('PRIMER_ERROR')
            $stderr.puts "#{record['PRIMER_ERROR']}"
            return p3_hash
          end
          pp_num = record['PRIMER_PAIR_NUM_RETURNED'].to_i
          if pp_num < 1
            $stderr.puts "Failed design for %s" % [seq_id]
            $stderr.puts "Left: #{record['PRIMER_LEFT_EXPLAIN']}"
            $stderr.puts "Right: #{record['PRIMER_RIGHT_EXPLAIN']}"
            $stderr.puts "Pair: #{record['PRIMER_PAIR_EXPLAIN']}"
            #exit
          end
          p3_hash[seq_id] = []
          (0...pp_num).each do |i|
            p3_hash[seq_id] << Amplicon.new(record, i, type='primer3')
          end
        end

        return p3_hash
      end
    end # Primer3Parser

  end # end Pcr module

end # end Qu module
