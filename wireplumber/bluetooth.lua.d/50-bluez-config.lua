bluez_monitor.enabled = true

bluez_monitor.properties = {
  -- These features do not work on all headsets, so they are enabled
  -- by default based on the hardware database. They can also be
  -- forced on/off for all devices by the following options:

  --["bluez5.enable-sbc-xq"] = true,
  --["bluez5.enable-msbc"] = true,
  ["bluez5.enable-hw-volume"] = true,

  -- See bluez-hardware.conf for the hardware database.

  -- Enabled headset roles (default: [ hsp_hs hfp_ag ]), this
  -- property only applies to native backend. Currently some headsets
  -- (Sony WH-1000XM3) are not working with both hsp_ag and hfp_ag
  -- enabled, disable either hsp_ag or hfp_ag to work around it.
  --
  -- Supported headset roles: hsp_hs (HSP Headset),
  --                          hsp_ag (HSP Audio Gateway),
  --                          hfp_hf (HFP Hands-Free),
  --                          hfp_ag (HFP Audio Gateway)
  --["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]",

  -- Enabled A2DP codecs (default: all).
  --["bluez5.codecs"] = "[ sbc sbc_xq aac ldac aptx aptx_hd aptx_ll aptx_ll_duplex faststream faststream_duplex ]",

  -- HFP/HSP backend (default: native).
  -- Available values: any, none, hsphfpd, ofono, native
  --["bluez5.hfphsp-backend"] = "native",

  -- Properties for the A2DP codec configuration
  --["bluez5.default.rate"] = 48000,
  --["bluez5.default.channels"] = 2,

  -- Register dummy AVRCP player, required for AVRCP volume function.
  -- Disable if you are running mpris-proxy or equivalent.
  --["bluez5.dummy-avrcp-player"] = true,

  -- Enable the logind module, which arbitrates which user will be allowed
  -- to have bluetooth audio enabled at any given time (particularly useful
  -- if you are using GDM as a display manager, as the gdm user also launches
  -- pipewire and wireplumber).
  -- This requires access to the D-Bus user session; disable if you are running
  -- a system-wide instance of wireplumber.
  ["with-logind"] = true,
}

bluez_monitor.rules = {
  -- An array of matches/actions to evaluate.
  {
    -- Rules for matching a device or node. It is an array of
    -- properties that all need to match the regexp. If any of the
    -- matches work, the actions are executed for the object.
    matches = {
      {
        -- This matches all cards.
        { "device.name", "matches", "bluez_card.*" },
      },
    },
    -- Apply properties on the matched object.
    apply_properties = {
      -- Auto-connect device profiles on start up or when only partial
      -- profiles have connected. Disabled by default if the property
      -- is not specified.
      --["bluez5.auto-connect"] = "[ hfp_hf hsp_hs a2dp_sink hfp_ag hsp_ag a2dp_source ]",
      ["bluez5.auto-connect"]  = "[ hfp_hf hsp_hs a2dp_sink ]",

      -- Hardware volume control (default: [ hfp_ag hsp_ag a2dp_source ])
      --["bluez5.hw-volume"] = "[ hfp_hf hsp_hs a2dp_sink hfp_ag hsp_ag a2dp_source ]",

      -- LDAC encoding quality
      -- Available values: auto (Adaptive Bitrate, default)
      --                   hq   (High Quality, 990/909kbps)
      --                   sq   (Standard Quality, 660/606kbps)
      --                   mq   (Mobile use Quality, 330/303kbps)
      --["bluez5.a2dp.ldac.quality"] = "auto",

      -- AAC variable bitrate mode
      -- Available values: 0 (cbr, default), 1-5 (quality level)
      --["bluez5.a2dp.aac.bitratemode"] = 0,

      -- Profile connected first
      -- Available values: a2dp-sink (default), headset-head-unit
      --["device.profile"] = "a2dp-sink",
    },
  },
  {
    matches = {
      {
        -- Matches all sources.
        { "node.name", "matches", "bluez_input.*" },
      },
      {
        -- Matches all sinks.
        { "node.name", "matches", "bluez_output.*" },
      },
    },
    apply_properties = {
      --["node.nick"] = "My Node",
      --["priority.driver"] = 100,
      --["priority.session"] = 100,
      --["node.pause-on-idle"] = false,
      --["resample.quality"] = 4,
      --["channelmix.normalize"] = false,
      --["channelmix.mix-lfe"] = false,
      --["session.suspend-timeout-seconds"] = 5,  -- 0 disables suspend
      --["monitor.channel-volumes"] = false,

      -- A2DP source role, "input" or "playback"
      -- Defaults to "playback", playing stream to speakers
      -- Set to "input" to use as an input for apps
      --["bluez5.a2dp-source-role"] = "input",
    },
  },
}
