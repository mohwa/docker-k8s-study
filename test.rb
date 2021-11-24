def hello_world(v = '', &block)
    puts v
    block.call v
end

hello_world 'test' do | vv |
 puts vv
end

def test_args(v = '', vv = {}, vvv = {})
    puts v
    puts vv
    puts vvv
end

test_args  "private_network", ip: "192.168.10.10#"
test_args  "private_network", { ip: "192.168.10.10#" }, { ip: "172.168.1.10#" }
