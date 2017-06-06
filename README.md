# code-snippets-puppet
Snippets of useful puppetcode

# user-data.epp
<p>
This is a Puppet EPP format template for AWS user-data for Windows and Linux.
Yes, one template for both.
</p><br />
<strong>usage:</strong>
(Full puppet-aws module ec2_instance example)
<pre>
ec2_instance { "myinstnace.example.com": 
  ensure               => present,
  region               => "us-west-2",
  availability_zone    => "us-west-2a",
  image_id             => "ami-id",
  instance_type        => "t2.small",
  key_name             => "your-key-name",
  security_groups      => ['standard-access'],
  tags                 =>  {
    "created_by"       => "paul.reed",
    "department"       => "tse",
    "project"          => "AWS Customer Demos & Testing",
  },
  <strong>user_data            => epp('demofiles/user-data.epp', {
    'puppet_master'    => 'master.example.com',
    'agent_certname'   => 'mynewclient.example.com',
    'os_type'          => 'Linux or Windows',
    'pp_preshared_key' => 'key, if using autosign',
    'pp_cloudplatform' => 'aws',
    'pp_role'          => 'role::my-role-for-this-host',
  }),</strong>
}
</pre>
