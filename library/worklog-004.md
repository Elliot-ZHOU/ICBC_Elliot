# worklog-004 — GOOGL / AI Chain Cube / FIDV
更新：2026-10-08 · 账号 GitHub `Franzpur` · 接续 worklog-003（满 10000 字开册）

格式：`U=`用户简令 · `A=`我方简应 · 够后续接续即可。流水序号全库连续。

---

## 1. 对话流水（压缩）

| # | U | A |
|---|---|---|
|120| 运行项目并展示现有展示页；呼出 prompt writer，写 Decision Cube 选中公司后的展示交互 prompt（左下放大、右上留原场景一角、空白处公司信息、关闭回原场景、进出直觉动画）。 | 任务：跑展示页并写选中公司展示交互 prompt。主代理先发现 8787 被 Downloads 旧副本占用并杀掉，再在本仓 `ai-chain/` 启动 server（首页/立方体可用，家数 98374）；服务仍在本机 8787 跑着。派 prompt writer 交主稿+精简版（不改代码）。无总监（无产品代码改动）。无总参谋部。 |
|121| Decision Cube：选中公司→左下放大聚焦→展示公司信息→关闭回原场景；×与点空白可关；进出直觉动画；可派 subagent。 | 任务：实现公司选中聚焦交互。主代理派美工部（玻璃族/动效量级）+explore；改 `cube.html`/`app.css`/`ui.js`/`scene.js`/CONCEPTS（C-COMPANY-ZOOM）。自测 Vistra 放大与×关闭回切片。总监第1次送审通过。未 push。8787仍可跑。 |
|122| 呼出 prompt writer：写数据集新建 Demo Company + 未来30年 bond 逐年本金/利息/本息；挂 Models & customer interface；随机合理不极端。 | 任务：写数据/模型挂接 prompt。派 prompt writer 交主稿+精简版；explore 核字段（`companies.json`，`layer_index=10`，现无 bond 字段）。不改代码。无总监。 |
|123| 数据集新增 Demo Company + 2026 起 30 年 bond 逐年本金/利息/本息（十亿美元）；挂 Models & customer interface；seed 后 cube 可见。 | 任务：落地 Demo Company 与 bond_schedule。改 `companies.json`（id=95, layer_index=10, bond_schedule）；`db.py` 增 bond_schedule 列与 API bondSchedule。seed 96 家；layer10=13。总监第1次通过。未 push。未做 bond UI。 |
|124| demo 30 年 bond 偿付曲线图（横轴时间、纵轴金额）；展示在 cube 点开公司底部；可派 subagent。 | 任务：聚焦面底部挂 bond 图。派美工部（合计 accent、本金/利息细线、无数据隐藏）。新增 `bondChart.js`；改 `ui.js`/`app.css`/CONCEPTS。自测 Demo Company 三线可见。总监第1次通过。未 push。 |
|125| 把目前修改 push 到 git。 | 按公私隔离 `git add` 工程路径（ai-chain 公司聚焦/Demo bond/曲线图 + worklog-003/004）；commit `72debbd`；已 push `origin/main`。工作树干净。无子代理。无总监（仅发布）。 |
|126| 改 progress 逻辑：仅各 agent/subagent 新开页首次呼出或业主要求时才读；并保存目前进度到 progress。 | 改本机 `.cursor/rules/progress.mdc`、`agent_tasklist/RULE.md`、`agents/*.md`+README、`agent_tasklist/prompt-writer.md`（默认不读；首次/点名才读）。重写仓根 `progress.md`（origin/main=`72debbd`；C-COMPANY-ZOOM/Demo/bond 图；待办 worklog #125）。均私有不进仓。无产品代码。无子代理。无总监。 |
|127| 呼出 prompt writer：Cube 三维下点 slice 只进对应 slice；搜索公司自动进该 slice 二维展示；三维不做公司缩放/详情（禁 C-COMPANY-ZOOM）。 | 任务：改写交互需求 prompt。主代理派 prompt-writer；交实现主稿+精简报文+3 待确认（三维点公司格、搜索是否自动开信息面、slice 点击范围）。无代码改动。无总监。 |
|128| 下达并实现 AI Cube 三维交互策略：点 slice 只进层；点公司格/搜索→先切该公司 slice 二维再开 C-COMPANY-ZOOM；三维禁 zoom。 | 任务：落地三维交互策略。主代理改 `ai-chain/`：`scene.js`（fromOverview）、`ui.js`（2D-only enter + 280ms delay）、`main.js` meta、`CONCEPTS.md`。总监第1次送审通过（agent 7cca1612）。未提交、未 push。 |
|129| 三维选 slice 进独立二维页，不要在三维里 C-PULL 该层。 | 任务：独立 /slice 页。explore（f957948e）确认无独立页；美工部（bcf5cb85）定延展 C-CUBE 玻璃。新建 `slice.html`/`slice.js`/`sliceNav.js`；路由 `/slice`；cube `focusSlice`/`selectCompany`→`goSlicePage`；CONCEPTS/AESTHETIC 更新。总监（ec36552f）第1次通过。8787 已重启。未提交。 |
|130| 回滚独立 /slice 二维页；保留同页三维禁 zoom / fromOverview。 | 任务：撤独立 slice 页。主代理删 `slice.html`/`slice.js`/`sliceNav.js` 与路由；`focusSlice` 恢复同页 C-PULL；三维禁 zoom / fromOverview 保留。总监（2890fdc4）第1次通过。未提交。 |
|131| 窗口打开项目检验。 | 任务：打开展示页供业主检验。主代理已开 `http://127.0.0.1:8787/cube`（Cursor 浏览器 + 系统浏览器尝试）；服务 :8787 在跑。无代码改动。无子代理。无总监。 |
|132| 写 progress.md；问相对 remote 未 push 的改动。 | 任务：更新 progress 并报告未提交/未 push 状态。主代理已更新本机 `progress.md`（至 #131；同页三维交互策略未提交；/slice 已回滚）。相对 `origin/main=72debbd`：无超前 commit；工作区未提交：`CONCEPTS.md`、`main.js`、`scene.js`、`ui.js`、`worklog-004.md`。无子代理。无总监。 |
|133| C-COMPANY-ZOOM「选中公司后展什么 / 如何展」；咨询信息部(manage)与 UI designer。 | 任务：咨询并融合 zoom 内容/布局建议。信息部：zoom 只服务认人+认链位+认偿债节奏；必显名/ticker/层/revBn/bondSchedule（无则占位）；有则行业坐标/主业占比/上市地/valueM/短注；不宜进 zoom：(s,x,y)/环分/source 等；债表几乎仅 Demo；立方体与门厅未打通。UI designer：延左下玻璃三区 A身份链位→B债图/缺数占位→C规模与有则字段；去掉现行不宜 kv；关闭仍×/空白/Esc；动效跟现有 scale。主代理已交融合提议；无代码改动、未提交；待业主下令是否实现。无总监。 |
|134| 电 prompt writer：写「C-FOCUS 底部 brief 开关控制 slice 公司名单面板显隐」可复制 prompt；默认 brief=on、会话内保持。 | 任务：改写 brief 开关需求 prompt。主代理派 prompt-writer；交主稿/精简版/可选美工部与报文稿。无代码改动。无总监。不改 progress。 |
|135| 实现 C-BRIEF：HUD chip「Brief」控制 C-FOCUS 下 #detailPanel/float-detail 名单显隐；默认 off；会话内保持。 | 任务：落地 C-BRIEF。美工部：chip 放 hud（Reset 后、d 前）。主代理改 `cube.html`/`ui.js`/`CONCEPTS.md`。总监第1次通过。未提交。不改 progress。 |
