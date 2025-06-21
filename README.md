# robust-functional-pipeline
### Enjoy the dark side of pure functions. And never write a `try/catch` again.

## 🛠 What is this?
A lightweight, composable framework to build **fault-tolerant data processing pipelines** in MATLAB — using functional programming patterns.

You define your workflow as a **computation table** (or equivalently, a cell array of functions), and process your input table **row by row**. Each row flows through a structured pipeline using a folded, monadic-like style.

The result? Clean logic, composable building blocks, and no more scattered error handling.

## ⚙️ Core Features

- **Exception-safe**: Robust try/catch logic is wrapped into the pipeline — no need for spaghetti exception code  
- **Composable**: Define computations in a table or cell array — easy to extend, reuse, and test  
- **Functional flavor**: Each unit only needs to know its input and returns its output  
- **Debuggable by design**: Pipeline traces, failure logs, and modular units make it transparent  

## 🧠 Advanced Use Case
For advanced users, the input data table itself can contain *functions* — allowing you to process entire **tables of chained test functions** (e.g., EoL test pipelines).

You can even define a `processTable` call *inside another* `processTable` pipeline. Yes, the system supports **unfolded nesting**.

## 🔍 Philosophy

We reject spaghetti logic. We reject brittle chains of imperatively coded steps.

Instead, we:
- Embrace **pure function boundaries**
- Elevate **computation-as-data**
- Use structured folding to sequence transformations with built-in exception safety

This is not just MATLAB. This is *clarity as a service*.

## 🚀 How to use it
You can define your pipeline in two ways:
- As a **computation table** with named pass/fail functions
- Or, using a simple **triplet-style cell array** for rapid prototyping

### 🔧 Example: Cell array definition

```matlab
pipeline = {
    'feature1', @(row) row.x + 1, @(row, err) 'Failed at feature1';
    'feature2', @(row) row.y * 2, [];  % uses default error handler
};

computationTable = createComputationTableFromCell(pipeline);

inputData = table((1:3)', (10:10:30)', 'VariableNames', {'x', 'y'});
output = processTable(inputData, computationTable);
disp(output.result{1});
```

This creates a clean, fail-safe pipeline where each computation is wrapped with fallback logic. You can go from prototype to production-ready just by swapping in more robust pass/fail functions.

## 📁 Examples
See the `examples/` folder for:
- Trivial computation pipelines  
- Error-handling and exception flow  
- Chained/nested pipeline logic  

## 👁 Audience
Anyone solving pipeline problems — especially in engineering, testing, or complex data workflows. If you think in DAGs, maps, or monads but have to write MATLAB... this is for you.
