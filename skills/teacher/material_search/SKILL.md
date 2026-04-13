---
name: "教学素材多站点检索与整理 (Material Search)"
description: "跨平台（学科网、教习网）检索教参、试卷等课件，结构化提取清单与获取地址"
---

# 教学素材跨平台检索 (Material Search) 执行指南

当用户提供 `keyword`（查询关键字）并触发本 Skill 时，作为 Claw 助手，你需要启动**浏览器自动化**(Browser Agent) 或对应的页面抓取工具执行跨站点的资源搜查任务。

## 🎯 核心目标
分别前往国内常用的教材聚合站点——【学科网】(zxxk.com)、【教习网】(51jiaoxi.com) 以及【Curriculum 知识库】检索相关资料。精准地将搜索结果列表中的 **文件名 (Title)** 以及 **资源详情/下载页 (URL)** 提取出来，生成可以直接交付给老师的高效导航表格。

## 🛠️ 标准执行流 (Workflow)

### 阶段一：检索【学科网】(zxxk.com)
1. 让浏览器访问 `https://www.zxxk.com/`，使用首页的搜索框输入并提交目标 `keyword`。如果能够判定编码规则，也可以尝试直接访问 `https://www.zxxk.com/search?keyword={keyword}`。
2. 等待搜索结果页面 DOM 加载完毕。
3. 提取当前页面排名前 N（N 由参数 `max_results_per_site` 控制，默认前 10 个）的资源：
   - 提取文件标题（名称）
   - 提取对应的详情页 `href` 链接（注意：如果拿到的是相对路径 `/soft/xxx.html`，必须将其拼接为完整的 `https://www.zxxk.com/soft/xxx.html` 格式）。
4. 将检索到的记录保存在本地内存上下文中。

### 阶段二：检索【教习网】(51jiaoxi.com)
1. 让浏览器访问 `https://www.51jiaoxi.com/`，利用搜索框输入并提交 `keyword`。同样也可尝试 `https://www.51jiaoxi.com/search?q={keyword}` 等快捷搜索路径。
2. 待列表出现后，提取前 N 项资料的信息。
3. 同样提取：
   - 文件名（包含年级、科目名称等）
   - 资源对应的实际落地地址 `href`
4. 加入全局缓存队列。

### 阶段三：检索【Curriculum 知识库】(Curriculum Platform)
1. 使用已配置的 `CURRICULUM_ACCESS_TOKEN` 环境变量（JWT Bearer Token）进行身份认证。
2. 调用 `GET /api/v1/documents/` 端点获取知识库文档列表：
   ```bash
   curl -X GET "https://edu-staging.njyaoduo.com/api/v1/documents/" \
     -H "Authorization: Bearer $CURRICULUM_ACCESS_TOKEN"
   ```
3. 在客户端对返回的文档进行关键字匹配过滤（匹配 `original_name` 字段包含 `keyword` 的文档）。
4. 如需分页或筛选处理状态，可使用查询参数：`filter_type=all|processed|pending|failed|recent`、`limit`、`offset`。
5. 将匹配到的文档记录加入结果队列。

### 阶段四：合并与输出 (Exporting)
检索完毕（无论单体平台是否因拦截而失败），你必须将存留的信息汇总为一份优美的 Markdown 表格，通过系统对话或 Markdown Artifact 交付给用户（培训老师）。

标准输出格式要求如下：

```markdown
### 🔍 素材检索报告：{keyword}

#### 知识库查询结果（如果提供了 knowledge_base_query）

**问题**：{knowledge_base_query}
**答案**：{知识库查询返回的答案}

#### 资源检索结果

| 来源平台 | 文件名称 (Title) | 获取/下载地址 (Link) |
| :------- | :--------------- | :------------------- |
| 学科网   | [2026]XX模拟题   | [前往下载](https...) |
| 学科网   | 同步课件PPT      | [前往下载](https...) |
| 教习网   | 第三单元练习.doc | [前往下载](https...) |
| Curriculum 知识库 | 高中数学知识点总结.pdf | [查看详情](https://edu-staging.njyaoduo.com/api/v1/documents/...) |
```

> **注意**：
> - 必须在回复中清晰提供点击即可跳转的长链接。
> - Curriculum 知识库的链接应指向文档详情页或使用 `/org/attachments/{id}/download` 格式提供下载链接。
> - 如果未提供 knowledge_base_query，则跳过知识库查询结果部分。

---

## ⚠️ 异常处理 & 边界情况 (Edge cases)

1. **反爬与滑块验证**：如果教习网或学科网弹出严苛的真人验证（滑块、文字点选）且你（Agent）无法自动化通过，**立即停止当前网站的提取并在最终报告标红告知用户遇到了验证码阻隔**，随后平滑转移至处理下一个网站。绝不允许直接挂起或报错退出。
2. **下载登录墙**：你的任务仅为**收集资源列表与详情URL**。请勿尝试深入到详情页内部去点“下载该资料”，因为这 100% 会触发网站的付费墙和强制微信扫码登录。
3. **空结果处理**：如果关键字过于冷门导致某个站点提示“没有找到相关素材”，请在结果报告中对应平台的位置输出 `该站点未检索到 {keyword} 相关的可用资源。`

4. **Curriculum 知识库认证失败**：如果 `CURRICULUM_ACCESS_TOKEN` 未配置或已失效，导致 API 调用返回 401/403 错误，请在最终报告中对应平台位置输出 `Curriculum 知识库访问失败（认证错误），请检查 CURRICULUM_ACCESS_TOKEN 配置`。**请勿在输出中打印 token 或错误详情**。

5. **知识库查询失败**：如果执行知识库查询时遇到错误（如网络问题、服务器错误等），请在最终报告中对应部分输出 `知识库查询失败，请稍后重试`。**请勿在输出中打印详细错误信息**。
