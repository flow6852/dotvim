import { Denops } from "https://deno.land/x/lspoints@v0.0.3/deps/denops.ts";
import {
  BaseExtension,
  Lspoints,
} from "https://deno.land/x/lspoints@v0.0.3/interface.ts";

// place to {runtimepath}/denops/@lspoints/config.ts

export class Extension extends BaseExtension {
  override initialize(denops: Denops, lspoints: Lspoints) {
    let startOptions = {
      // TypeScript way to given options
      denols: {
        cmd: ["deno", "lsp"],
        initializationOptions: {
          enable: true,
          unstable: true,
        },
      },
    }
    if(await denops.call('executable marksman')) {
        const marksman = {
            marksman: {
                cmd: ["marksman", "server"],
            }
        }
        startOptions = { ...startOptions, ...marksman }
    }

    lspoints.settings.patch({
      startOptions: startOptions
    });
  }
}
