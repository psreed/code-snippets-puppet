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
  'puppet_master'    => '<yer master>',
  'agent_certname'   => '<yer wanted fqdn>',
  'os_type'          => '<Linux || Windows>',
  'pp_preshared_key' => '<fun key stuff>',
  'pp_cloudplatform' => '<whatever you want, i used "aws">',
  'pp_role'          => '<whatever you want>',
}),
</pre>