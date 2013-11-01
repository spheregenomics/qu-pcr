#!/usr/bin/env ruby

module Qu
  module Pcr
    class Primer 
      attr_reader :type, :tm, :penalty, :pos, :seq, :gc
      def initialize(seq = nil, 
                     type = nil,
                     gc = nil,
                     tm = nil,
                     penalty = nil,
                     pos = nil)


        # type should be "forward" or "reverse"
        @type = type

        @gc = gc.to_f
        @tm = tm.to_f
        @penalty = penalty.to_f
        # position of primer's 5' end
        @pos = pos.to_i
        @seq = Bio::Sequence::NA.new(seq)
      end
    end

    class Product
      attr_reader :tm, :opt_a, :seq, :size, :id, :penalty
      def initialize(seq = nil, 
                     tm = nil,
                     opt_a = nil,
                     size = nil,
                     id = nil,
                     penalty = nil)
        @tm = tm.to_f
        @size = size.to_i
        @opt_a = opt_a.to_f
        @seq = Bio::Sequence::NA.new(seq)
        @id = id.to_s
        @penalty = penalty.to_f
      end
  
    end

    class VirtualGel
      PARA = {
        0.5 => {
        'a' => 2.7094,
        'b' => 0.2691,
        'k' => 464.4412
      },
        1.0 => {
        'a' => 2.3977,
        'b' => 0.2700,
        'k' => 73.9788
      },
        1.5 => {
        'a' => 2.3221,
        'b' => 0.2634,
        'k' => 48.0873
      },
        2.0 => {
        'a' => 2.1333,
        'b' => 0.2561,
        'k' => 18.5417
      }}

      def self.get_para(gel_conc)
        a = PARA[gel_conc]['a']
        b = PARA[gel_conc]['b']
        k = PARA[gel_conc]['k']
        return a, b, k
      end

      def self.cal_mobility(size, gel_conc=1.0, ref_mobility=50)
        a, b, k = get_para(gel_conc)
        return ((a - b * Math.log(size + k)) * ref_mobility.to_f).round(2)
      end

      def self.cal_size(mobility, gel_conc=1.0, ref_mobility=50)
        a, b, k = get_para(gel_conc)
        return (Math.exp((a - mobility / ref_mobility.to_f) / b) - k).round
      end

      def self.cal_size_range(size, offset=2, gel_conc=1.0, ref_mobility=50)
        y = cal_mobility(size, gel_conc, ref_mobility)
        x_min = cal_size(y + offset, gel_conc, ref_mobility)
        x_max = cal_size(y - offset, gel_conc, ref_mobility)
        return x_min, x_max
      end
    end # VirtualGel
  end
end

if $0 == __FILE__
  #p Qu::Pcr::VirtualGel.cal_mobility(100)
  #p Qu::Pcr::VirtualGel.cal_mobility(200)
  #p Qu::Pcr::VirtualGel.cal_size(44)
  #p Qu::Pcr::VirtualGel.cal_size_range(200)
  p Qu::Pcr::VirtualGel.cal_size_range(119, 1.5, 1.0)
end
