require 'rails_helper'

def char_replacer word, subs
  word.chars.map { |c| subs.key?(c) ? subs[c] : c }.join
end

RSpec.describe Message, type: :model do
  before do
    User.delete_all
    Room.delete_all
  end

  let(:room_users_json) {'{\"user1\":\"examplez\",\"user2\":\"example22\"}'}

  describe 'correct room creating with room_users' do
    it 'should create room and pass validations' do
      room1 = Room.new(name: 'test_room')
      room1.valid?
      room1.save
      room2 = Room.new(name: 'dual_room', room_users: room_users_json)
      room2.valid?
      room2.save
      expect(room1.errors.first).to eq(nil)
      expect(room2.errors.first).to eq(nil)
    end
  end

  describe 'incorrect room creating when name is nil with room_users' do
    it 'should fail validation and drop fail message' do
      room1 = Room.new
      room1.valid?
      room1.save
      room2 = Room.new(room_users: room_users_json)
      room2.valid?
      room2.save
      expect(room1.errors.first.attribute).to eq(:name)
      expect(room1.errors.first.type).to eq(:blank)
      expect(room2.errors.first.attribute).to eq(:name)
      expect(room2.errors.first.type).to eq(:blank)
    end
  end

  describe 'dual rooms used only for dialogs(eq 2 people in room only, messenger realisation)' do 
    room_users_json_any_unprocessed = ''
    count = rand(3...50)
    count.times do
      random_number1 = rand(3...50)
      random_number2 = rand(51..100)
      my_replaces = { '1' => "#{random_number1}", 'z' => "#{random_number2}" }
      room_users_json_any_unprocessed += (char_replacer("\"user1\":\"examplez\",", my_replaces))
    end
    room_users_json_any = '{' + room_users_json_any_unprocessed[0...-1] + '}'
    it 'should fail validation when user number != 2 and pass validation when user number == 2' do
      room1 = Room.new(name:"dual_room", room_users: "{\"user1\":\"examplez\",\"user2\":\"example22\"}")
      room1.valid?
      room1.save
      room2 = Room.new(name: 'dual_room', room_users: "{\"user1\":\"examplez\"}")
      room2.valid?
      room2.save
      room3 = Room.new(name: 'dual_room', room_users: room_users_json_any)
      room3.valid?
      room3.save
      expect(room1.errors.first).to eq(nil)
      expect(room2.errors.first.attribute).to eq(:json_records_count)
      expect(room2.errors.first.type).to eq(:equal_to)
      expect(room2.errors.first.options).to eq({ if: :is_json?, count: 2, value: 1 })
      expect(room3.errors.first.attribute).to eq(:json_records_count)
      expect(room3.errors.first.type).to eq(:equal_to)
      expect(room3.errors.first.options).to eq({ if: :is_json?, count: 2, value: room3.json_records_count })
    end
  end

  describe 'we cant create reverse room [(u1, u2) and (u2, u1)]' do
    let(:room1) {Room.new(name: "dual_room", room_users: "{\"user1\":\"examplez\",\"user2\":\"example22\"}")}
    let(:room2) {Room.new(name: "dual_room", room_users: "{\"user1\":\"example22\",\"user2\":\"examplez\"}")}
    it 'should fail validation and drop fail message' do
      room1.save
      expect(room1.errors.first).to eq(nil)
      room2.save
      expect(room2.errors.first.attribute).to eq(:room_users)
      expect(room2.errors.first.type).to eq(:other_than)
    end
  end

  describe 'we cant create room with not unique users names' do
    let(:room) {Room.new(name: "dual_room", room_users: "{\"user1\":\"examplez\",\"user2\":\"examplez\"}")}
    it 'should fail validation and drop fail message' do
      room.save
      expect(room.errors.first.attribute).to eq(:are_hash_element_unique)
      expect(room.errors.first.type).to eq(:blank)
    end
  end

  describe 'availability room users as json not nil informs that we have necessarily only two users and dual_room for them' do
    let(:room) {Room.new(name: "not_dual_room", room_users: "{\"user1\":\"example1\",\"user2\":\"example2\"}")}
    it 'should fail validation and drop fail message' do
      room.save
      expect(room.errors.first.attribute).to eq(:name)
      expect(room.errors.first.type).to eq(:equal_to)
    end
  end
end
