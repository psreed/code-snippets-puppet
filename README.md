# code-snippets-puppet
Snippets of useful puppetcode

# user-data.pp
<p>
This is a Puppet EPP format template for AWS user-data for Windows and Linux.
Yes, one template for both.
</p><br />
usage:<br />
<pre>
user_data            => epp('demofiles/user-data.epp', {
  'puppet_master'    => 'master.example.com',
  'agent_certname'   => 'mynewclient.example.com',
  'os_type'          => 'Linux or Windows',
  'pp_preshared_key' => 'key, if using autosign',
  'pp_cloudplatform' => 'aws',
  'pp_role'          => 'role::my-role-for-this-host',
}),
</pre>