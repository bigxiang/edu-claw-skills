<p align="center">
  <img src="assets/logo.png" width="300" alt="Edu-Claw-Skills Logo">
</p>

# Edu-Claw-Skills 📚

## 🎯 项目简介 (Project Overview)

本项目旨在为 **Claw** 智能引擎提供无缝接入 **Curriculum 教学平台** 的能力储备（Skills）。基于本项目，Claw 能够以 AI 智能助手的身份，针对不同业务线的使用人群（培训老师、教育组织人员、学生），提供高度定制化、自动化的平台操作和智能辅助能力。

通过将功能颗粒化为针对性的 Skill，Claw 便能准确理解不同角色的需求并在底层调用对应的 Curriculum API，从而大幅提升教育场景下的运作效率和师生体验。

---

## 🏗️ 项目架构 (Architecture)

本项目的运作基于以下三层架构：

1. **底层服务层 (Curriculum Platform Layer)** 
   基于 Curriculum 平台对外暴露的 OpenAPI 接口底座。本项目通过自动拉取、同步 `openapi.json` 从而保证接口定义随时最新（详见 `api_docs/API_DOCS.md`）。
   
2. **基建与数据层 (Infrastructure & Data Layer)** 
   - **公共能力 (curriculum)**：承担总括性的鉴权 (`AUTH.md`)、课程宏观理念 (`KNOWLEDGE.md`) 与课程规划生成等全局能力。
   - **脚本和模型封装 (scripts)**：负责从 API 自动清洗、生成便于各个智能体直接调用的 Pydantic Models。

3. **智能体技能层 (Agent Skill Layer)** 
   真正面向大模型（Claw）的执行层，根据业务角色将平台能力封装为一个个独立的原子级与大颗粒结合的 Skill 文件夹。每个 Skill 都包含明确的 Prompt 定义 (`SKILL.md`) 乃至配置文件参数。

---

## 👥 目标人群与核心技能划分

按照使用人群的应用场景，目前的专属智能化技能分类如下：

### 👨‍🏫 1. 培训老师 (Teachers)
侧重于知识源文件的沉淀、智能教参研磨和测评一体化：
* **素材采集 (Material Collection)**：将外部资料、文档、视频一键归档。
* **素材解析 (Material Parsing)**：自动对上传资料进行清理和切割，结构化数据。
* **素材分类 (Material Classification)**：依据智能分析对教学知识资产打上领域标签和难度维度。
* **素材检索 (Material Search)**：基于语义和标签的素材快速寻源。
* **课件生成 (Courseware Generation)**：根据素材和指定的结构，一键生成培训 PPT 及讲义（Transcripts，乃至视频生成）。
* **试题生成 (Exam Generation)**：基于课件内容和教学节点生成配套练习和测试题目。
* **试题批改 (Exam Grading)**：智能阅读学生提交的主客观题并给出点评分析。

### 🏢 2. 教育组织人员 (Organizers)
侧重于教务流管理、项目统筹以及人员数据掌握：
* **培训班管理 (Class Management)**：快捷地进行建班、教师指派、班级排期以及开课动作。
* **培训人员信息统计 (User Statistics)**：拉取并分析多维度的学员画像、培训参与度以及结业达成率。
* **培训考试管理 (Exam Management)**：调度考试题库、排考及试卷的分级分发。

### 🎓 3. 学生 (Students)
侧重于终端消费者的学习追踪和 AI 精准助学服务：
* **参加课程查看 (Course Viewer)**：查看当前个人的课程资源、录播回放及课件。
* **参加培训班查看 (Class Viewer)**：查阅所属班级的近期计划表和教务通知。
* **参考考试查看 (Exam Viewer)**：获取待考项目和历史考卷记录。
* **知识点查看 (Knowledge Points)**：按照结构化的 Curriculum 树随时浏览所学技能节点的掌握情况。
* **复习辅导 (Review Assistant)**：提取薄弱知识点，让 AI 基于此生成定制复习内容。

---

## 📁 目录结构 (Directory Structure)

我们将以上功能落实为以下的文件目录架构规范，以便于独立扩展与后续的 Prompt 调试：

```text
edu-claw-skills/
├── README.md                           # 项目总说明文档
└── skills/
    ├── curriculum/                     # 核心 API 基建与全局能力声明
    │   ├── openapi.json                # API 原始契约
    │   ├── API_DOCS.md                 # 自动生成的可读接口参考
    │   ├── SKILL.md                    # 全局通用的 Curriculum 基本 Prompt 策略
    │   ├── AUTH.md                     # 全局鉴权接入流程
    │   ├── KNOWLEDGE.md                # Curriculum 平台术语和流程规范库
    │   └── scripts/                    # OpenAPI 自动抓取更新等基建脚本
    │
    ├── teacher/                        # 👨‍🏫 培训老师动作合集
    │   ├── material_collection/        #   └── 此处对应"素材采集"对应的 skill 配置
    │   ├── material_parsing/           #   └── "素材解析" (基于 document run-all 工具)
    │   ├── material_classification/    #   └── "素材分类" 
    │   ├── material_search/            #   └── "素材检索"
    │   ├── courseware_generation/      #   └── "课件生成" (调用 outline/ppt/video 接口生成流水线)
    │   ├── exam_generation/            #   └── "试题生成" (结合 practice-questions 生成逻辑)
    │   └── exam_grading/               #   └── "试题批改"
    │
    ├── organizer/                      # 🏢 教育组织机构能力合集
    │   ├── class_management/           #   └── "建班与下发" 
    │   ├── user_statistics/            #   └── "学员通过率/学习偏好统计"
    │   └── exam_management/            #   └── "统筹考务计划"
    │
    └── student/                        # 🎓 学生查询与助学合集
        ├── course_viewer/              #   └── "课程查询" 
        ├── class_viewer/               #   └── "班级信息查询"
        ├── exam_viewer/                #   └── "考试计划与记录查询"
        ├── knowledge_points/           #   └── "核心技能节点追踪查询"
        └── review_assistant/           #   └── "薄弱环节针对性 AI 辅导"
```

## 🚀 接入与使用说明

1. **环境准备:** 该仓库维护的均是给大模型/Agent 消费的自然语言逻辑 (`SKILL.md`) 及工具脚本。如果你使用到了代码执行部分（如生成 Pydantic 等），确保您的 Python 环境符合相关依赖（例如配置了 `datamodel-code-generator`）。
2. **技能加载:** Claw 或任何目标 Agent 通过加载本项目的 `/skills/{角色}/{功能}` 路径中的 `skill.json` 以及 `SKILL.md` 等，即可注册该动作。
3. **接口同步:** 如果后端的 API 发生了变动，请进入 `skills/curriculum` 并按照内部脚本说明运行拉取更新，确保 Agent 的 API 认知同步一致。