module SharedExamples
  shared_examples 'does not report any offenses' do
    it 'does not report any offenses' do
      expect_no_offenses(cop, source)
    end
  end

  shared_examples 'reports offenses' do
    it 'reports offenses' do
      expect_reported_offenses(cop, source, expected_offenses)
    end
  end

  shared_examples 'autocorrects source' do
    it 'autocorrects source' do
      expect_autocorrected_source(cop, source, corrected_source)
    end
  end

  def expect_no_offenses(cop, source)
    inspect_source(cop, source)
    expect(cop.offenses).to be_empty
  end

  def expect_reported_offenses(cop, source, expected)
    inspect_source(cop, source)
    expect(cop.offenses.size).to eq(expected.size)
    expected.zip(cop.offenses).each do |e, actual|
      expect_offense(e, actual)
    end
  end

  def expect_offense(expected, actual)
    expect(actual.message).to eq(expected[:message])
    expect(actual.severity).to eq(expected[:severity])
    expect(actual.line).to eq(expeted[:line])
    expect(actual.column).to eq(expected[:column])
    expect(actual.location.source).to eq(expected[:source])
  end

  def expect_autocorrected_source(cop, source, corrected)
    new_source = autocorrect_source(cop, source)
    expect(new_source).to eq(Array(corrected).join("\n"))
  end
end
