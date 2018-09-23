#!/usr/bin/env ruby

require 'date'
require 'pry'

print "What's the dose?(ml)\n"
dose_input = gets.chomp.to_f

print "When are you starting?(IE, 01-01-2018)\n"
start = gets.chomp

def run(*args)
    Dosage.new(*args)
    return nil
end

class Dosage
    attr_accessor :dose,
                  :current_day,
                  :schedule


    def initialize(start, dose)
        @current_day = start
        @dose = dose
        @schedule = []
        calculate_schedule
        format_and_print_schedule
    end

    def calculate_schedule
        if self.dose > 0.1
            schedule << {
                date: self.current_day,
                dose: calculate_dose
            }

            self.current_day += 5
            self.dose = (self.dose - 0.1).round(1)
            calculate_schedule
        end
    end


    def format_and_print_schedule
        puts "\n"
        schedule.each do |data|
            puts "#{data[:date].to_s}"
            puts "AM: #{data[:dose][:am]}   |   PM: #{data[:dose][:pm]}"
        end
    end


    def calculate_dose
        if self.dose <= 0.5
            am = self.dose
            pm = "none"
        else
            am = am_dose(self.dose)
            pm = pm_dose(self.dose)
        end

        {
            am: am,
            pm: pm
        }
    end

    def am_dose(dose)
        (dose/2.0).round(1)
    end

    def pm_dose(dose)
        (((dose * 10)/2).floor.to_f)/10
    end

end

run(Date.parse(start), dose_input)
