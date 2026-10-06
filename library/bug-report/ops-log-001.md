# ops-log-001 — FIDV 运行问题
更新：2026-10-06 · 书记处运维 · 接 clone/ingest 空名单

格式：现象 · 原因 · 解法 · 路径。流水序号全库连续。

---

## 1. 问题流水

| # | 现象 | 原因 | 解法 | 路径 |
|---|---|---|---|---|
|1| GitHub 克隆后首页有分类格、家数 0、四级无公司 | 成员库 `bics_entities_20261003.db` gitignore，clone 不带；ingest 造库不是连库；`app.py` 按路径打开文件 | 终端进入仓库根目录：`pip3 install openpyxl` 后 `python3 class-3-coords/BICS-Classification/ingest_20261003_entities.py`；`quit` 再开 `./Open-AI-Cube.command` | `library/showable-report/FIDV-clone-handbook.html` |
|2| 2026-10-06 业主 PDF《FIDV 问题手册 · GitHub 克隆后分类空》（接 worklog #97–#99）：clone 后用启动器开首页，分类格在、家数全 0、四级无公司 | ① 成员库 `bics_entities_20261003.db` 故意不进 git，须 `ingest_20261003_entities.py` 从 DATA-SPACE xlsx 生成（依赖 openpyxl）；启动器只跑 `seed.py` 不跑 ingest，服务照起却无公司可数 ② 三个 `.command`/`.sh` 在 git 中为 100644，clone 后双击失败；仓库无 `.gitignore`（历史均为网页 "Add files via upload"，点文件与执行位丢失）③ 本机复现：新 clone 无成员库，Python 3.12.3 无 openpyxl | 父代理已改：启动器在成员库缺失或旧于任一 xlsx 时按需 `pip install --user openpyxl`（失败去 `--user` 重试）并跑 ingest，失败只告警给手动命令不阻断；ingest 先写 `.db.tmp` 再替换；三脚本改 100755；新增 `.gitignore`（`ai_chain.db`、成员库及 `.tmp`、`~$*.xlsx`、`.DS_Store`、`__pycache__`）；两份 README 补自动生成说明与 Windows 手动两步。验证：rows=117255 reject=26 l4_codes=225；各 L1 家数非 0（Communications 3215、Industrials 13114）；`10101010` count=581；二次启动跳过 ingest。总监终审通过 | `ai-chain/Open-AI-Chain.command`、`Open-AI-Cube.command`、`ai-chain/scripts/set-command-icon.sh`、`class-3-coords/BICS-Classification/ingest_20261003_entities.py`、`.gitignore`、`README.md`、`ai-chain/README.md` |
