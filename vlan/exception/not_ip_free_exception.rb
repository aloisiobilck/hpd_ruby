class NotIpFreeException < StandardError
  def initialize(msg="Não há IP's disponíveis para esta VLAN")
    super
  end
end