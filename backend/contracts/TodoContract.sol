// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.9;

contract TodoContract {
    uint256 public taskCount;

    struct Task {
        uint256 index;
        string taskName;
        bool isComplete;
    }

    mapping(uint256 => Task) public todos;

    event TaskCreated(string task, uint256 taskNumber);
    event Taskupdated(string task, uint256 taskId);
    event TaskIsCompletedToggled(string task, uint256 taskId, bool isCompleted);
    event TaskDeleted(uint256 taskNumber);

    function createTask(string memory _taskName) public {
        todos[taskCount] = Task(taskCount, _taskName, false);
        taskCount++;
        emit TaskCreated(_taskName, taskCount - 1);
    }

    function updateTask(uint256 _taskId, string memory _taskName) public {
        Task memory currTask = todos[_taskId];
        todos[_taskId] = Task(_taskId, _taskName, currTask.isComplete);
        emit Taskupdated(_taskName, _taskId);
    }

    function toggelComplete(uint256 _taskId) public {
        Task memory currTask = todos[_taskId];
        todos[_taskId] = Task(_taskId, currTask.taskName, !currTask.isComplete);

        emit TaskIsCompletedToggled(currTask.taskName, _taskId, !currTask.isComplete);
    }

    function deleteTask(uint256 _taskId) public {
        delete todos[_taskId];
        emit TaskDeleted(_taskId);
    }
}