
pragma solidity ^0.8.0;

contract GradeBook {
    address public owner;
    
    struct Grade {
        string studentName;
        string subject;
        uint256 grade;
    }
    
    Grade[] public grades;
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    function addGrade(string memory _studentName, string memory _subject, uint256 _grade) public onlyOwner {
        grades.push(Grade(_studentName, _subject, _grade));
    }
    
    function updateGrade(uint256 _index, uint256 _newGrade) public onlyOwner {
        require(_index < grades.length, "Invalid index.");
        grades[_index].grade = _newGrade;
    }
    
    function getGrade(uint256 _index) public view returns (string memory, string memory, uint256) {
        require(_index < grades.length, "Invalid index.");
        Grade memory grade = grades[_index];
        return (grade.studentName, grade.subject, grade.grade);
    }
    
    function averageGrade(string memory _subject) public view returns (uint256) {
        uint256 totalGrade = 0;
        uint256 count = 0;
        for (uint256 i = 0; i < grades.length; i++) {
            if (keccak256(bytes(grades[i].subject)) == keccak256(bytes(_subject))) {
                totalGrade += grades[i].grade;
                count++;
            }
        }
        if (count > 0) {
            return totalGrade / count;
        } else {
            return 0;
        }
    }
}
