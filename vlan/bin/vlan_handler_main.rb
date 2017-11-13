require '../lib/email_validator.rb'
require '../lib/vlan_handler.rb'
require 'logger'

class VlanHandlerMain

  @@vlans_available = {'1': 'vlan_dev'}

  def main
    vlan_handler = VlanHandler.new('../var/ips.leases')
    logger = Logger.new("../log/ip-alloc_#{Time.new.strftime('%Y-%m-%d')}.log")
    logger.datetime_format = '%d-%m-%Y %H:%M:%S'
    email_validator = EmailValidator.new
    puts '::: HPD IPAlloc v1.0 :::'
    is_valid_email = false
    while !is_valid_email
      puts "\n Digite seu endereço de e-mail (é necessário que o email seja válido):"
      email = gets.to_str.strip
      if(email_validator.valid?(email))
        is_valid_email = true
        logger.add(Logger::INFO) { "Acceso de usuário registrado: #{email}" }
      end
    end
    is_valid_option = false
    option_chosen = nil
    while !is_valid_option
      puts "\nEscolha a VLAN que você obter um IP:\n\n"
      @@vlans_available.each {|key, value| puts "[#{key}] #{value}" }
      option_chosen = gets.strip.to_sym
      if (self.is_valid_option?(option_chosen))
        is_valid_option = true
      end
    end
    vlan_chosen = @@vlans_available[option_chosen]
    ip = vlan_handler.get_ip(vlan_chosen)
    puts "\nIP obtido com êxito: #{ip}"
    logger.add(Logger::INFO) { "IP #{ip} [#{vlan_chosen}] concedido com êxito ao usuário #{email}" }
    rescue NotIpFreeException => e
      puts "\n" + e.message + ": #{vlan_chosen}"
      logger.add(Logger::ERROR) { "Falha ao obter endereço IP. #{e.message}: #{vlan_chosen}. Usuário: #{email}" }
  end

  def is_valid_option?(option)
    return @@vlans_available.key?(option)
  end

end


  if __FILE__ == $PROGRAM_NAME
  x = VlanHandlerMain.new
  x.main
  end

  

