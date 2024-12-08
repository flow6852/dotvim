import {
  BaseConfig,
  ContextBuilder,
  Dpp,
  Plugin,
} from "https://deno.land/x/dpp_vim@v0.0.5/types.ts";
import { Denops, fn } from "https://deno.land/x/dpp_vim@v0.0.5/deps.ts";

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
  }): Promise<{
    plugins: Plugin[];
    stateLines: string[];
  }> {
    args.contextBuilder.setGlobal({
      protocols: ["git"],
    });

    type Toml = {
      hooks_file?: string;
      ftplugins?: Record<string, string>;
      plugins?: Plugin[];
    };

    type LazyMakeStateResult = {
      plugins: Plugin[];
      stateLines: string[];
    };

    type ExtType = {
      target: string;
      isLazy: boolean;
      ext: string;
      os: string;
    };

    const [context, options] = await args.contextBuilder.get(args.denops);
    const dotfilesDir = "~/.vim/plugs/";

    // for using toml
    const tomls: Toml[] = [];
    const recordPlugins: Record<string, Plugin> = {};
    const os = Deno.build.os;

    // with lazy
    for (
      const file of [
        { target: "dpp.toml", isLazy: true, os: "" },
        { target: "base_lazy.toml", isLazy: true, os: "" },
        { target: "denops_lazy.toml", isLazy: true, os: "" },
        { target: "vime.toml", isLazy: true, os: "" },
      ] as ExtType[]
    ) {
      if (os == file.os || file.os == "") {
        tomls.push(
          await args.dpp.extAction(
            args.denops,
            context,
            options,
            "toml",
            "load",
            {
              path: await fn.expand(args.denops, dotfilesDir + "tomls/" + file.target),
              options: {
                lazy: file.isLazy,
                merged: false,
              },
            },
          ) as Toml,
        );

        const ftplugins: Record<string, string> = {};
        const hooksFiles: string[] = [];

        tomls.forEach((toml) => {
          for (const plugin of toml.plugins) {
            recordPlugins[plugin.name] = plugin;
          }

          if (toml.ftplugins) {
            for (const filetype of Object.keys(toml.ftplugins)) {
              if (ftplugins[filetype]) {
                ftplugins[filetype] += `\n${toml.ftplugins[filetype]}`;
              } else {
                ftplugins[filetype] = toml.ftplugins[filetype];
              }
            }
          }

          if (toml.hooks_file) {
            hooksFiles.push(toml.hooks_file);
          }
        });
      }
    }

    // from local
    for (const target of ["local"]) {
      (await args.dpp.extAction(
        args.denops,
        context,
        options,
        "local",
        "local",
        {
          directory: dotfilesDir + target,
          options: {
            merged: false,
          },
        },
      ) as Plugin[]).forEach((plugin: Plugin) => {
        recordPlugins[plugin.name] = plugin;
      });
    }

    const result = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "lazy",
      "makeState",
      {
        plugins: Object.values(recordPlugins),
      },
    ) as LazyMakeStateResult;

    return {
      plugins: result.plugins,
      stateLines: result.stateLines,
    };
  }
}
