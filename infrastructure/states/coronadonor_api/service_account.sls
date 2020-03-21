{% set username = salt['pillar.get']('coronadonor_api:service_account', 'coronadonor_api_development') %}
service account {{ username }}:
  user.present:
    - name: {{ username }}

{% set ssh_public_keys = [

'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtau6aLCLseOEAHhsVGf3kevbCrZFe3OHku2osqkWM6asVV/erT3iHOBmxIcUEUaenyA1GSul/ohKaodH5gwbQsb/aGmPPgKT6T9DQ3rsonr9vxZXarkxgodBh2LPcsknywoBCVAWlibWk1xLjkbqqIyF8jhTOCj9PSX06fbF0X7IxRTWzUf4Qg5QABgNqOULObhWA+RObV7cbav7sBUbI8YliWJbitdXm4dtAwYirv2K0sJarvJRANvoJc7IA4BJr6yiKDZ6yAdMQhEvPrNku0a+JPg/KDgqoLv5wU8zLMmx4X2Nlem5NLlTQrFi6s2gB6YqlYwTPngh73vbVpXJx skrobul@Mareks-Mac-Pro.local',

] %}


{% for key in ssh_public_keys %}
deployment ssh key for {{ username }}:
  ssh_auth.present:
    - user: {{ username }}
    - name: {{ key }}
{% endfor %}


