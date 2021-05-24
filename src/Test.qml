import QtQuick 2.0
import QtTest 1.2

TestCase {
    id: test
    name: "UnitTests"

    function test_shooting(bullet) {
        compare(bullet.x + bullet.newX, result)
    }

    function benchmark_create_component_player() {
            var component = Qt.createComponent("Player.qml")
            var obj = component.createObject(top)
            obj.destroy()
            component.destroy()
    }

    function benchmark_create_component_enemy() {
            var component = Qt.createComponent("Enemy.qml")
            var obj = component.createObject(top)
            obj.destroy()
            component.destroy()
    }

    function benchmark_create_component_boss() {
            var component = Qt.createComponent("Boss.qml")
            var obj = component.createObject(top)
            obj.destroy()
            component.destroy()
    }

    function benchmark_create_component_bullet() {
            var component = Qt.createComponent("Bullet.qml")
            var obj = component.createObject(top)
            obj.destroy()
            component.destroy()
    }

    function test_environment_offset(data) {
          return [
                {tag: "data.x + data.offset = data.answer1", data: data },
                {tag: "data.y + data.offset = data.answer2", data: data },
            ]
    }

    function test_player_offset(data) {
          return [
                {tag: "data.x + data.offset = data.answer1", data: data },
                {tag: "data.y + data.offset = data.answer2", data: data },
            ]
    }

    function test_environment(data) {
          compare(data.x + data.y, data.result)
    }

    function test_environment_initialization(data) {
          compare(data.x + data.y, data.result)
    }
}
