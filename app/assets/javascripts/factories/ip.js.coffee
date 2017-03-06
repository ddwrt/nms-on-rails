angular.module('ngNms').factory('nmsIp', ['$resource', 'nmsInfo', 'nmsArp', 'nmsSystem', ($resource, nmsInfo, nmsArp, nmsSystem) -> 

  # r = $resource(window.BASEURL + '/networks/:network_id/ips/:id.json?search_string=wilder', 
  r = $resource(window.BASEURL + '/ips.json', 
      { id:'@id' }, 
      { update: { method: 'PUT' }}
  )

  r.prototype.nmsinfo = ->
    if ! @singleton_info
      @singleton_info = new nmsInfo(@info)
    @singleton_info

  r.prototype.nmsarp = ->
    if ! @singleton_arp
      @singleton_arp = new nmsArp(@arp)
    @singleton_arp

  r.prototype.nmssystem = ->
    if ! @singleton_system
      @singleton_system = new nmsSystem(@system)
    @singleton_system

  #r.prototype.toggle_protocol = ->
    #@conn_proto = switch @conn_proto
    #              when null   then 'ssh'
    #              when 'ssh'  then 'rdp'
    #              when 'rdp'  then 'http'
    #              when 'http' then 'ssh'
    #
    #@.$update()

  r.prototype.conn_link = ->
    proto = switch this.nmssystem().name
      when "linux"   then "ssh"
      when "macos"   then "ssh"
      when "printer" then "html"
      when "win7"    then "rdp"
      when "xp"      then "rdp"
      else "html"
    
    window.BASEURL + "/ips/#{@id}/connect.#{proto}"
    #if @conn_proto
    #  proto = @conn_proto
    #  proto = 'html' if proto == 'http'
    #  window.BASEURL + "/ips/#{@id}/connect.#{proto}"
    #else
    #  ""

  r.prototype.wake_link = ->
    window.BASEURL + "/ips/#{@id}/wake.wol"

  r
])

