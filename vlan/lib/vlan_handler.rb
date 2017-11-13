require '../exception/not_ip_free_exception'

class VlanHandler
  
  def initialize(file_path)
    @file_path = file_path
  end

  def get_ip(vlan)
    has_free = false
    ip = '0.0.0.0'
    File.open(@file_path, 'r+') do |out_file|
      File.open(@file_path, 'r').each do |line|
        if((line.strip.split(':')[0].eql?(vlan)) && (line.strip.split(':')[2].eql?('free')))
          out_file.print line.sub('free', 'busy')
          ip = line.strip.split(':')[1]
          has_free = true
          break
        else
          out_file.print line
        end
      end
    end
    if(!has_free)
      raise NotIpFreeException
    end
    return ip
  end
  
end