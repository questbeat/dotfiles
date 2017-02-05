function knife_solo_provision_target
  __select_target_host | read -l target_host
  test -z $target_host; and return
  echo Provisioning $target_host...

  knife solo prepare $target_host $argv; \
    and knife solo cook $target_host $argv
end
