class ocf_www::site::shorturl {
  $canonical_url = $::host_env ? {
    'dev'  => 'https://dev-ocf-io.ocf.berkeley.edu/',
    'prod' => 'https://ocf.io/',
  }

  apache::vhost { 'shorturl':
    servername    => 'ocf.io',
    serveraliases => ['dev-ocf-io.ocf.berkeley.edu', 'www.ocf.io'],
    port          => 443,
    docroot       => '/var/www/html',

    ssl           => true,
    ssl_key       => "/etc/ssl/private/${::fqdn}.key",
    ssl_cert      => "/etc/ssl/private/${::fqdn}.crt",
    ssl_chain     => "/etc/ssl/private/${::fqdn}.intermediate",

    rewrites      => [
      # Short URLs
      # Remember to add these to the list of RESERVED_USERNAMES in ocflib/account/validators.py
      {rewrite_rule => '^/?$ https://www.ocf.berkeley.edu/ [R=301]'},
      {rewrite_rule => '^/about$ https://www.ocf.berkeley.edu/docs/about/ [R]'},
      {rewrite_rule => '^/absa$ https://drive.google.com/drive/folders/0B7n5VUVfGPUoV0xPREIwY0hzc0E?usp=sharing [R]'},
      {rewrite_rule => '^/account$ https://www.ocf.berkeley.edu/docs/services/account/ [R]'},
      {rewrite_rule => '^/apphost$ https://www.ocf.berkeley.edu/docs/services/webapps/ [R]'},
      {rewrite_rule => '^/announce$ https://groups.google.com/a/lists.berkeley.edu/forum/#!forum/ocf/join [NE,R]'},
      {rewrite_rule => '^/bjb$ https://jukebox.ocf.berkeley.edu/ [R]'},
      {rewrite_rule => '^/bod(/.*)?$ https://www.ocf.berkeley.edu/~staff/bod$1 [R]'},
      {rewrite_rule => '^/buy$ https://goo.gl/forms/PnlB5dJawGZcUS0S2 [R]'},
      {rewrite_rule => '^/buysheet$ https://docs.google.com/spreadsheets/d/16tMZGSrr3D6ao8V-cIyeE5PTEYf1XQEQ9rALGAjoWls/edit?usp=sharing [R]'},
      {rewrite_rule => '^/callinkapi(.*)?$ https://studentgroupservice.sait-west.berkeley.edu/service.asmx$1 [R]'},
      {rewrite_rule => '^/contact$ https://www.ocf.berkeley.edu/docs/contact/ [R]'},
      {rewrite_rule => '^/d$ https://discourse.ocf.berkeley.edu/ [R]'},
      {rewrite_rule => '^/d/([0-9]+)$ https://discourse.ocf.berkeley.edu/t/$1 [R]'},
      {rewrite_rule => '^/decal(/.*)?$ https://decal.ocf.berkeley.edu$1 [R]'},
      {rewrite_rule => '^/decalform$ https://docs.google.com/forms/d/e/1FAIpQLSdM-fxPBzNtPA3RgzcxYLmZAo-pGCCS9fkLYdDZiNCbKjickw/viewform [R]'},
      {rewrite_rule => '^/decalzoom$ https://berkeley.zoom.us/j/94285257750?pwd=OGx1TUlKWmNrQnNwdkxwRTlSL2VTUT09 [R]'},
      {rewrite_rule => '^/desktopstats$ https://grafana.ocf.berkeley.edu/d/-VCUTE8Zk/desktops?orgId=1&refresh=10s [R]'},
      {rewrite_rule => '^/discord$ https://discord.gg/mwhu5eh [R]'},
      {rewrite_rule => '^/docs(/.*)?$ https://www.ocf.berkeley.edu/docs$1 [R]'},
      {rewrite_rule => '^/donate$ https://give.berkeley.edu/egiving/index.cfm?fund=FU1450000&org=Open+Computing+Facility&amt=&fundlist=FU1450000 [R]'},
      {rewrite_rule => '^/email-update$ https://status.ocf.berkeley.edu/2014/06/email-discontinuation-update-forward.html [R]'},
      {rewrite_rule => '^/eligibility$ https://www.ocf.berkeley.edu/docs/membership/eligibility/ [R]'},
      {rewrite_rule => '^/families$ https://docs.google.com/presentation/d/1y49eQj-SPIsMtIio2KFx86SF6tKcv1yB16pO6AS2uk4/edit [R]'},
      {rewrite_rule => '^/faq$ https://www.ocf.berkeley.edu/docs/faq/ [R]'},
      {rewrite_rule => '^/gh/([^/]*)(/(?!blob/)(?!tree/)(?!info/)(?!issue)(?!pull).+)$ https://ocf.io/gh/$1/blob/master$2 [R]'},
      {rewrite_rule => '^/gh/i(/.*)?$ https://github.com/ocf/ircbot$1 [R]'},
      {rewrite_rule => '^/gh/l(/.*)?$ https://github.com/ocf/ocflib$1 [R]'},
      {rewrite_rule => '^/gh/p(/.*)?$ https://github.com/ocf/puppet$1 [R]'},
      {rewrite_rule => '^/gh/u(/.*)?$ https://github.com/ocf/utils$1 [R]'},
      {rewrite_rule => '^/gh/w(/.*)?$ https://github.com/ocf/ocfweb$1 [R]'},
      {rewrite_rule => '^/gh(/.*)?$ https://ocf.io/github$1 [R]'},
      {rewrite_rule => '^/github(/.*)?$ https://github.com/ocf$1 [R]'},
      {rewrite_rule => '^/gadmin$ https://admin.google.com/a/ocf.berkeley.edu [R]'},
      {rewrite_rule => '^/gcal$ https://calendar.google.com/a/ocf.berkeley.edu [R]'},
      {rewrite_rule => '^/get(ing)?involved$ https://www.ocf.berkeley.edu/docs/staff/getinvolved/ [R]'},
      {rewrite_rule => '^/gcal/ocf$ https://calendar.google.com/calendar/embed?src=ocf.berkeley.edu_bcl2puplt6t9e9e9njme6jqca8@group.calendar.google.com&ctz=America/Los_Angeles [R]'},
      {rewrite_rule => '^/gcal/officers$ https://calendar.google.com/calendar/embed?src=ocf.berkeley.edu_3e56a1lm5gnd91vf1r7fafi7u4@group.calendar.google.com&ctz=America/Los_Angeles [R]'},
      {rewrite_rule => '^/gmail$ https://mail.google.com/a/ocf.berkeley.edu [R]'},
      {rewrite_rule => '^/gdrive$ https://drive.google.com/a/ocf.berkeley.edu [R]'},
      {rewrite_rule => '^/gdrive/staff$ https://drive.google.com/drive/folders/0AKXh7iBur_mbUk9PVA [R]'},
      {rewrite_rule => '^/gdrive/officers$ https://drive.google.com/drive/folders/0APZdR8kE4NN1Uk9PVA [R]'},
      {rewrite_rule => '^/guest$ https://goo.gl/forms/ImNfnZkrRrakZcIr1 [R]'},
      {rewrite_rule => '^/help(/.*)?$ https://www.ocf.berkeley.edu/docs$1 [R]'},
      {rewrite_rule => '^/hiring$ https://docs.google.com/forms/d/e/1FAIpQLSdYNN5oeGU6wDTbjkGOIzOlqsv75illO3tHCwgAQ_RgzLh8gQ/viewform [R]'},
      {rewrite_rule => '^/hosting$ https://www.ocf.berkeley.edu/docs/services/web/ [R]'},
      {rewrite_rule => '^/hours$ https://ocf.io/lab#hours [R,NE]'},
      {rewrite_rule => '^/hpc$ https://www.ocf.berkeley.edu/docs/services/hpc/ [R]'},
      {rewrite_rule => '^/hpcstats$ https://grafana.ocf.berkeley.edu/d/N7Sb3nwik/hpc-slurm-dashboard?orgId=1&refresh=30s [R]'},
      {rewrite_rule => '^/https$ https://status.ocf.berkeley.edu/2014/10/moving-wwwocfberkeleyedu-to-https-only.html [R]'},
      {rewrite_rule => '^/infra$ https://docs.google.com/presentation/d/1CcwdR3x8CPaBPcHI4yzQ35hvmkZZ4FGagnpDfQAvg-o/edit [R]'},
      {rewrite_rule => '^/internals?$ https://docs.google.com/presentation/d/1SJsXAcGYVZxwA1GWH2B6vPrKcJKa-kDk7AW0xKK31ps/edit [R]'},
      {rewrite_rule => '^/irc$ https://www.ocf.berkeley.edu/docs/contact/irc/ [R]'},
      {rewrite_rule => '^/job$ https://docs.google.com/document/d/1oS3ma415LbtuyeEuuoucWKYLcWOJaWmzhv2nIs5f718/edit [R]'},
      {rewrite_rule => '^/join$ https://www.ocf.berkeley.edu/account/register/ [R]'},
      {rewrite_rule => '^/joinstaff$ https://docs.google.com/presentation/d/1VMUVfoeVWcRFEdYf9C6TbYyYuoZFzLfWVKySHnZGpEE/edit [R]'},
      {rewrite_rule => '^/k$ https://kanboard.ocf.berkeley.edu/ [R]'},
      {rewrite_rule => '^/k/a$ https://kanboard.ocf.berkeley.edu/?controller=BoardViewController&action=show&project_id=2 [R]'},
      {rewrite_rule => '^/k/([0-9]+)$ https://kanboard.ocf.berkeley.edu/?controller=TaskViewController&action=show&task_id=$1 [R]'},
      {rewrite_rule => '^/register$ https://www.ocf.berkeley.edu/account/register/ [R]'},
      {rewrite_rule => '^/reserve$ https://www.ocf.berkeley.edu/docs/services/lab/lab-reservation-policy/ [R]'},
      {rewrite_rule => '^/lab$ https://www.ocf.berkeley.edu/docs/services/lab/ [R]'},
      {rewrite_rule => '^/mail$ https://www.ocf.berkeley.edu/docs/services/vhost/mail/ [R]'},
      {rewrite_rule => '^/mailrequest$ https://www.ocf.berkeley.edu/account/vhost/mail/ [R]'},
      {rewrite_rule => '^/mastodon$ https://mastodon.ocf.berkeley.edu [R]'},
      {rewrite_rule => '^/matrix$ https://chat.ocf.berkeley.edu [R]'},
      {rewrite_rule => '^/minutes(/.*)?$ https://www.ocf.berkeley.edu/~staff/bod$1 [R]'},
      {rewrite_rule => '^/mirrorstats$ https://grafana.ocf.berkeley.edu/d/Jo_bRsyiz/mirrors?orgId=1 [R]'},
      {rewrite_rule => '^/mlk$ https://www.ocf.berkeley.edu/mlk [R]'},
      {rewrite_rule => '^/(mon|munin)$ https://munin.ocf.berkeley.edu/ [R]'},
      {rewrite_rule => '^/mysql$ https://www.ocf.berkeley.edu/docs/services/mysql/ [R]'},
      {rewrite_rule => '^/officers$ https://www.ocf.berkeley.edu/docs/about/officers/ [R]'},
      {rewrite_rule => '^/opstaff-schedule$ https://docs.google.com/spreadsheets/d/185MB6nxajC1SsTXWW3lsgSXESomYdW_6pbUiEEFjisU/edit?usp=sharing [R]'},
      {rewrite_rule => '^/os$ https://docs.google.com/spreadsheets/d/1V4qYWOjQiafE_Xr-4X4nCUI1Sux5yJQNqHgzLV8j76I/edit [R]'},
      {rewrite_rule => '^/password$ https://www.ocf.berkeley.edu/account/password [R]'},
      {rewrite_rule => '^/printerlog$ https://docs.google.com/spreadsheets/d/1f4rLSmVt11oeFmO1yUUcXa-JcyFmDtloTWrYYPfYJoU/edit?usp=sharing [R]'},
      {rewrite_rule => '^/printers$ https://grafana.ocf.berkeley.edu/d/SKl6_71iz [R]'},
      {rewrite_rule => '^/printerstats$ https://grafana.ocf.berkeley.edu/d/SKl6_71iz [R]'},
      {rewrite_rule => '^/printing$ https://www.ocf.berkeley.edu/announcements/2016-02-09/printing [R]'},
      {rewrite_rule => '^/projects$ https://github.com/ocf/projects/issues [R]'},
      {rewrite_rule => '^/referendum-cost-breakdown$ https://docs.google.com/spreadsheets/d/1vIwrHlYtn1IcFH-1pTbUw2JvKNsR4rwlUzCJUbapID8/edit?usp=sharing [R]'},
      {rewrite_rule => '^/register2vote$ https://www.vote.org/register-to-vote/ [R]'},
      {rewrite_rule => '^/rt/?$ https://rt.ocf.berkeley.edu/ [R]'},
      {rewrite_rule => '^/rt/([0-9]+)$ https://rt.ocf.berkeley.edu/Ticket/Display.html?id=$1 [R]'},
      {rewrite_rule => '^/rt/([a-z]+)$ https://rt.ocf.berkeley.edu/Search/Results.html?Query=Queue\\ =\\ \'$1\'\\ AND\\ Status\\ =\\ \'__Active__\' [R]'},
      {rewrite_rule => '^/sdocs(/.*)?$ https://www.ocf.berkeley.edu/docs/staff$1 [R]'},
      {rewrite_rule => '^/senate-resolution$ https://docs.google.com/document/d/1UwjX4BJIzeQ6XjGBHu2rA51XUjywTBtPTzJN2CMGU4o/edit [R]'},
      {rewrite_rule => '^/senate-presentation$ https://docs.google.com/presentation/d/16EDXf0mhGKM_xQrfuG7giXMUbITQ1U-5U5yynL8mms4/edit [R]'},
      {rewrite_rule => '^/servers$ https://www.ocf.berkeley.edu/docs/staff/backend/servers/ [R]'},
      {rewrite_rule => '^/serverstats$ https://grafana.ocf.berkeley.edu/d/7n0r8PUWz/servers?orgId=1&refresh=10s [R]'},
      {rewrite_rule => '^/signin$ https://goo.gl/forms/j2NU4u3T1pMKIPpu1 [R]'},
      {rewrite_rule => '^/shorturl$ https://github.com/ocf/puppet/blob/master/modules/ocf_www/manifests/site/shorturl.pp [R]'},
      {rewrite_rule => '^/slack$ https://www.ocf.berkeley.edu/docs/contact/slack/ [R]'},
      {rewrite_rule => '^/social-?rules$ https://www.recurse.com/social-rules [R]'},
      {rewrite_rule => '^/ssh$ https://www.ocf.berkeley.edu/docs/services/shell/ [R]'},
      {rewrite_rule => '^/staff$ https://www.ocf.berkeley.edu/about/staff [R]'},
      {rewrite_rule => '^/staffhours$ https://ocf.io/staff-hours [R]'},
      {rewrite_rule => '^/staff-hours$ https://www.ocf.berkeley.edu/staff-hours [R]'},
      {rewrite_rule => '^/staff_hours$ https://ocf.io/staff-hours [R]'},
      {rewrite_rule => '^/starter-?tasks$ https://www.ocf.berkeley.edu/docs/staff/startertasks/ [R]'},
      {rewrite_rule => '^/stats(/.*)?$ https://www.ocf.berkeley.edu/stats$1 [R]'},
      {rewrite_rule => '^/status$ https://status.ocf.berkeley.edu/ [R]'},
      {rewrite_rule => '^/swag$ https://ocf.io/s/swag [R]'},
      {rewrite_rule => '^/buster$ https://www.ocf.berkeley.edu/docs/staff/backend/buster/ [R]'},
      {rewrite_rule => '^/s/(.+)$ https://www.ocf.berkeley.edu/api/shorturl/$1 [R]'},
      {rewrite_rule => '^/stf-cost-breakdown$ https://docs.google.com/spreadsheets/d/1U3YfU5S1hyi4c9u1vME84lz5hQPz23LKWCaD8mq4JHI/edit [R]'},
      {rewrite_rule => '^/survey$ https://goo.gl/forms/sk1s0dnuxDY71vBR2 [R]'},
      {rewrite_rule => '^/tw(/.*)?$ https://ocf.io/twitter$1 [R]'},
      {rewrite_rule => '^/twitter(/.*)?$ https://twitter.com/ucbocf$1 [R]'},
      {rewrite_rule => '^/tv(/.*)?$ https://www.ocf.berkeley.edu/tv$1 [R]'},
      {rewrite_rule => '^/vhost$ https://www.ocf.berkeley.edu/docs/services/vhost/ [R]'},
      {rewrite_rule => '^/vhost-mail$ https://www.ocf.berkeley.edu/docs/services/vhost/mail/ [R]'},
      {rewrite_rule => '^/wiki$ https://www.ocf.berkeley.edu/docs/ [R]'},
      {rewrite_rule => '^/wordpress$ https://www.ocf.berkeley.edu/docs/services/web/wordpress/ [R]'},
      {rewrite_rule => '^/web$ https://www.ocf.berkeley.edu/docs/services/web/ [R]'},
      {rewrite_rule => '^/xkcd$ https://xkcd.ocf.berkeley.edu/ [R]'},
      {rewrite_rule => '^/youtube$ https://www.youtube.com/channel/UCx6SI8vROy9UGje0IiLkk8w [R]'},
      {rewrite_rule => '^/zoom$ https://berkeley.zoom.us/j/92953066816 [R]'},

      # Otherwise, send a temporary redirect to the appropriate userdir
      {rewrite_rule => '^/~?([a-z]{3,16}(?:/.*)?)$ https://www.ocf.berkeley.edu/~$1 [R]'},
    ],

    headers       => ['always set Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"'],
  }

  # canonical redirects
  apache::vhost { 'shorturl-http-redirect':
    servername      => 'ocf.io',
    serveraliases   => ['dev-ocf-io.ocf.berkeley.edu', 'www.ocf.io'],
    port            => 80,
    docroot         => '/var/www/html',

    redirect_status => 301,
    redirect_dest   => $canonical_url;
  }
}
