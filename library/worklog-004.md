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
